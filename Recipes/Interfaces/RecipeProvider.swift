import Foundation

protocol RecipeProvider {
    static func getRecipes() async throws -> [any RecipeInterface]
}

