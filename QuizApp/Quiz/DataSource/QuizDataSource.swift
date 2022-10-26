protocol QuizDataSourceProtocol {

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizModel]
    
    func getAllQuizzes(accessToken: String) async throws -> [QuizModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private var quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizModel] {
        return try await quizClient.getQuizzes(for: category, accessToken: accessToken)
    }

    func getAllQuizzes(accessToken: String) async throws -> [QuizModel] {
        return try await quizClient.getAllQuizzes(accessToken: accessToken)
    }

}
