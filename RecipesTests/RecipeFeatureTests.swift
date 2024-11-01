import Testing
import ComposableArchitecture
@testable import Recipes

struct RecipeFeatureTests {

    
    struct TestRecipe: RecipeInterface {
        var cuisine: String?
        var name: String?
        var photoUrlLarge: String?
        var photoUrlSmall: String?
        var sourceUrl: String?
        var uuid: String?
        var youtubeUrl: String?
        
        
        init(cuisine: String? = nil, name: String? = nil, photoUrlLarge: String? = nil, photoUrlSmall: String? = nil, sourceUrl: String? = nil, uuid: String? = nil, youtubeUrl: String? = nil) {
            self.cuisine = cuisine
            self.name = name
            self.photoUrlLarge = photoUrlLarge
            self.photoUrlSmall = photoUrlSmall
            self.sourceUrl = sourceUrl
            self.uuid = uuid
            self.youtubeUrl = youtubeUrl
        }
        
    }
    
    @Test func testAlertTextIsUpdated() async throws {
        let store = await TestStore(initialState: RecipeFeature.State()) {
            RecipeFeature()
        }
        
        let text = "API Error!"
        await store.send(.isAlertTextChanged(text)) {
            $0.alertText = text
        }
    }
    
    @Test func testFilterTextIsUpdated() async throws {
        let store = await TestStore(initialState: RecipeFeature.State()) {
            RecipeFeature()
        }
        
        let filterText = "Italian"
        await store.send(.updateFilter(filterText)) {
            $0.filter = filterText
        }
        
        await store.receive(\.updateData) {
            $0.data = .empty
        }
    }
    
    @Test func testDataStateIsUpdated() async throws {
        let store = await TestStore(initialState: RecipeFeature.State()) {
            RecipeFeature()
        }
        
        await store.send(.updateData(.empty)) {
            $0.data = .empty
        }
        
    }
    
    @Test func testUpdateRecipeProgressState() async throws {
        let store = await TestStore(initialState: RecipeFeature.State()) {
            RecipeFeature()
        }
        
        await store.send(.update(.idle))
        
        await store.send(.update(.loading)) {
            $0.progress = .loading
        }
        
        let text = "Some error"
        await store.send(.update(.error(text))) {
            $0.progress = .error(text)
        }
        await store.receive(\.isAlertTextChanged, timeout: 60) {
            $0.alertText = "Some error"
        }
        
    }
    
    @Test func testFetchRecipes() async throws {
        
        let recipes = [TestRecipe(name: "Test Recipe")]
        let store = await TestStore(initialState: RecipeFeature.State()) {
            RecipeFeature()
        } withDependencies: { deps in
            deps.recipeService.fetchRecipes = { //Injected a "Test Recipe"
                return recipes
            }
        }
        await store.send(.fetchRecipes)
        await store.receive(\.update) {
            $0.progress = .loading
        }
        let anyRecipes: [AnyRecipe] = recipes.map { AnyRecipe($0) }
        await store.receive(\.fetchRecipesResponse) {
            $0.recipes = anyRecipes
            $0.filteredRecipes = anyRecipes
        }
        await store.receive(\.update) {
            $0.progress = .idle
        }
        await store.receive(\.updateData) {
            $0.data = .success
        }
    }
}

