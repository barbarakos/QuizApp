enum QuizError {

    case empty
    case serverError

    var info: ErrorInfo {
        switch self {
        case .empty:
            return ErrorInfo(
                title: "No data",
                description: "There are no available quizzes for this category.")
        case .serverError:
            return ErrorInfo(
                title: "Error",
                description: "Data can't be reached. Please try again.")
        }
    }

}
