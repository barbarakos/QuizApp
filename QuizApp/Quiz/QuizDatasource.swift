protocol QuizDatasourceProtocol {

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizModel]

}

class QuizDatasource: QuizDatasourceProtocol {

    private var quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizModel] {
        return try await quizClient.getQuizzes(for: category, accessToken: accessToken)
    }

}
