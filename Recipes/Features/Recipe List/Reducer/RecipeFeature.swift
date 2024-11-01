import ComposableArchitecture
import OpenAPIClient
import Foundation

@Reducer
struct RecipeFeature {
    
    @Dependency(\.recipeService) var recipeService
    
    @ObservableState
    struct State: Equatable {
        var recipes: [AnyRecipe] = []
        var filteredRecipes: [AnyRecipe] = []
        var progress: ProgressState = .idle
        var data: DataState = .initial
        var filter: String = ""
        var alertText: String?
    }
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case fetchRecipes
        case fetchRecipesResponse(Result<[AnyRecipe],Error>)
        case update(ProgressState)
        case updateData(DataState)
        case updateFilter(String)
        case isAlertTextChanged(String?)
    }
    
    enum ProgressState: Equatable {
        case idle
        case loading
        case error(String)
    }
    
    enum DataState {
        case initial
        case empty
        case success
    }
    
    var body: some Reducer<State,Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.filter):
                return .send(.updateFilter(state.filter))
                    .debounce(id: "FilterDebounce",
                              for: .milliseconds(300),
                              scheduler: DispatchQueue.main)
            case .binding:
                //additional logic to perform
                //on binding change can go here.
                return .none
            case .isAlertTextChanged(let str):
                state.alertText = str
                return .none
            case .updateFilter(let filterText):
                state.filter = filterText
                if filterText.isEmpty {
                    state.filteredRecipes = state.recipes
                } else {
                    state.filteredRecipes = state.recipes.filter {
                        $0.name?.localizedCaseInsensitiveContains(filterText) ?? false ||
                        $0.cuisine?.localizedCaseInsensitiveContains(filterText) ?? false
                    }
                    
                    if state.filteredRecipes.isEmpty {
                        return .send(.updateData(.empty))
                    }
                }
                return .send(.updateData((state.filteredRecipes.isEmpty ? .empty : .success)))
            case .fetchRecipes:
                return .run { send in
                    await send(.update(.loading))
                    let response = try await recipeService.fetchRecipes()
                    let mapped = response.compactMap { item in
                        AnyRecipe(item)
                    }
                    await send(.fetchRecipesResponse(.success(mapped)))
                }
            case .fetchRecipesResponse(let result):
                switch result {
                case .success(let recipes):
                    state.recipes = recipes
                    state.filteredRecipes = recipes
                    return .run { [_state = state] send in
                        if !_state.filter.isEmpty {
                            await send(.updateFilter(_state.filter))
                        }
                        await send(.update(.idle))
                        await send(.updateData((recipes.isEmpty ? .empty : .success)))
                    }
                case .failure(let error):
                    return .run { send in
                        await send(.update(.idle))
                        await send(.update(.error(error.localizedDescription)))
                    }
                }
            case .update(let newState):
                state.progress = newState
                switch newState {
                case .error(let str):
                    return .send(.isAlertTextChanged(str))
                default:
                    break
                }
                return .none
            case .updateData(let newState):
                state.data = newState
                return .none
            }
        }
    }
}



