protocol QuizDataSourceProtocol {

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizDataSourceModel]

    func getAllQuizzes(accessToken: String) async throws -> [QuizDataSourceModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private var quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizDataSourceModel] {
        return try await quizClient.getQuizzes(for: category, accessToken: accessToken)
            .map { QuizDataSourceModel(from: $0) }
    }

    func getAllQuizzes(accessToken: String) async throws -> [QuizDataSourceModel] {
        return try await quizClient.getAllQuizzes(accessToken: accessToken)
            .map { QuizDataSourceModel(from: $0) }
    }

}
