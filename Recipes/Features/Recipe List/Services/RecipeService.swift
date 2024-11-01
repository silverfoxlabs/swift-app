import OpenAPIClient
import ComposableArchitecture

struct RecipeService: RecipeProvider {
    
    private static var endpoint: Int {
        Int.random(in: 0...2) // Assign a random integer between 0 and 2
    }
    
    var fetchRecipes: () async throws -> [any RecipeInterface]
    
    /**
     For the exercise, randomly call the endpoints to show the different data states
     */
    static func getRecipes() async throws -> [any RecipeInterface] {
        
        switch Self.endpoint {
        case 0:
            return try await RecipesAPI.getRecipes().recipes ?? []
        case 1:
            return try await RecipesAPI.getMalformedRecipes().recipes ?? []
        case 2:
            return try await RecipesAPI.getEmptyRecipes().recipes ?? []
        default:
            return []
        }
    }
}

extension RecipeService: DependencyKey {
    static let liveValue = Self {
        try await Self.getRecipes()
    }
}

extension DependencyValues {
    var recipeService: RecipeService {
        get { self[RecipeService.self] }
        set { self[RecipeService.self] = newValue }
    }
}
