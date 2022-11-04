protocol QuizDataSourceProtocol {

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizDataModel]

    func getAllQuizzes(accessToken: String) async throws -> [QuizDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private var quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizDataModel] {
        return try await quizClient.getQuizzes(for: category, accessToken: accessToken)
            .map { QuizDataModel(from: $0) }
    }

    func getAllQuizzes(accessToken: String) async throws -> [QuizDataModel] {
        return try await quizClient.getAllQuizzes(accessToken: accessToken)
            .map { QuizDataModel(from: $0) }
    }

}
