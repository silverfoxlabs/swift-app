import SwiftUI
import ComposableArchitecture

@main
struct RecipesApp: App {
    
    @Environment(\.scenePhase) private var scenePhase: ScenePhase
    
    @Bindable var store: StoreOf<AppFeature> = {
        .init(initialState: AppFeature.State(isReachable: true), reducer: {
            AppFeature()
        })
    }()
    
    @State var recipeStore: StoreOf<RecipeFeature> = .init(initialState: RecipeFeature.State(), reducer: {
        RecipeFeature()
    })
    @State var offline: Bool = false
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                VStack {
                    if store.lifecycleState == .startup {
                        Text("Starting up, Please Wait...")
                    } else if store.lifecycleState == .active {
                        RecipeListView(store: recipeStore)
                    }
                }
                //We use .constant here to make sure that if SwiftUI re-renders the view
                //the alert will still show again if still offline.
                .alert("Offline", isPresented: .constant(store.offline)) {
                    Button("Ok") {}
                }
            }
        }
        .onChange(of: scenePhase, { oldValue, newValue in
            print(#function)
            print("New Value of Scene Phase: \(newValue)")
            
            switch newValue {
            case .active:
                if store.lifecycleState != .active {
                    store.send(.lifecycleEventChanged(.active))
                }
            case .inactive:
                if store.lifecycleState != .inactive {
                    store.send(.lifecycleEventChanged(.inactive))
                }
            case .background:
                if store.lifecycleState != .background {
                    store.send(.lifecycleEventChanged(.background))
                }
            default:
                break
            }
        })
        
    }
    
}

