import SwiftUI
import OpenAPIClient
import ComposableArchitecture

struct RecipeListView: View {
    
    @Bindable var store: StoreOf<RecipeFeature>
    
    var body: some View {
        Text("Put your UI Here!")
    }
}



#Preview {
    var recipeData: [AnyRecipe] {
        let decoder = JSONDecoder()
        if let path = Bundle.main.path(forResource: "valid", ofType: "json"), let url = URL(string: path), let data = try? Data(contentsOf: url), let recipes = try? decoder.decode(
            [RecipesInner].self,
            from: data
        ) {
        
            return recipes.map {
                AnyRecipe($0)
            }
            
        }
        
        return []
    }
    
    NavigationStack {
        RecipeListView(store: Store(initialState: RecipeFeature.State(recipes: recipeData, filteredRecipes: recipeData), reducer: {
            RecipeFeature()
        }))
        .navigationTitle("Recipes")
    }
    
}


