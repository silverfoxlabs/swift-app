import Foundation

protocol RecipeInterface: Equatable {
    var cuisine: String? { get }
    var name: String? { get }
    var photoUrlLarge: String? { get }
    var photoUrlSmall: String? { get }
    var sourceUrl: String? { get }
    var uuid: String? { get }
    var youtubeUrl: String? { get }
}

extension RecipeInterface {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
