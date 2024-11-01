import Foundation


func isAscii(_ input: String) -> Bool {
    if let _ = input.data(using: .ascii, allowLossyConversion: false) {
        return true
    }
    return false
}

