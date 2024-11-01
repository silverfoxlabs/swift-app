import Foundation

enum AnyError: Error, LocalizedError {
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .custom(let description):
            return description
        }
    }
}

