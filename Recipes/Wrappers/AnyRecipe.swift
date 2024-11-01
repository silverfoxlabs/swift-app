import Foundation

struct AnyRecipe: RecipeInterface, Equatable {
    /**
        Since AnyRecipe is a type-erased wrapper,
        it needs to store properties for any type conforming to RecipeInterface.
        The concrete type of the wrapped object is not known at compile time,
        so the closures provide a way to store the access logic for these properties in a uniform way.
        It would be trivial to modify the logic in this file should there be a need to do some additional
        processing for example.
     */
    private let _cuisine: () -> String?
    private let _name: () -> String?
    private let _photoUrlLarge: () -> String?
    private let _photoUrlSmall: () -> String?
    private let _sourceUrl: () -> String?
    private let _uuid: () -> String?
    private let _youtubeUrl: () -> String?

    var cuisine: String? { _cuisine() }
    var name: String? { _name() } //Can we add the malformed string checks here?
    var photoUrlLarge: String? { _photoUrlLarge() }
    var photoUrlSmall: String? { _photoUrlSmall() }
    var sourceUrl: String? { _sourceUrl() }
    var uuid: String? { _uuid() }
    var youtubeUrl: String? { _youtubeUrl() }

    init<T: RecipeInterface>(_ recipe: T) {
        _cuisine = { recipe.cuisine }
        _name = { recipe.name }
        _photoUrlLarge = { recipe.photoUrlLarge }
        _photoUrlSmall = { recipe.photoUrlSmall }
        _sourceUrl = { recipe.sourceUrl }
        _uuid = { recipe.uuid }
        _youtubeUrl = { recipe.youtubeUrl }
    }

    static func == (lhs: AnyRecipe, rhs: AnyRecipe) -> Bool {
        lhs.uuid == rhs.uuid
    }
}

extension RandomAccessCollection where Element == AnyRecipe {
    
}
