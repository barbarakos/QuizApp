import Foundation

struct ErrorAlert: LocalizedError {

    let err: ValidationError

    var errorDescription: String? {
        err.errorTitle
    }

    var recoverySuggestion: String? {
        err.errorDescription
    }

    init?(error: ValidationError?) {
        guard let error = error else { return nil }

        self.err = error
    }

}
