import Foundation

enum ValidationError {

    case noAccount
    case emptyUsername

    var errorTitle: String {
        switch self {
        case .noAccount:
            return "Incorrect email/password"
        case .emptyUsername:
            return "Name cannot be empty!"
        }
    }

    var errorDescription: String {
        switch self {
        case .noAccount:
            return "Try again."
        case .emptyUsername:
            return "Please enter a valid name."
        }
    }

}
