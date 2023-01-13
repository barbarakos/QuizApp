import Foundation

enum ValidationError {

    case noAccount
    case emptyUsername
    case serverError

    var errorTitle: String {
        switch self {
        case .noAccount:
            return "Incorrect email/password"
        case .emptyUsername:
            return "Name cannot be empty!"
        case .serverError:
            return "Server error!"
        }
    }

    var errorDescription: String {
        switch self {
        case .noAccount:
            return "Try again."
        case .emptyUsername:
            return "Please enter a valid name."
        case .serverError:
            return "There was a problem connecting to server."
        }
    }

}
