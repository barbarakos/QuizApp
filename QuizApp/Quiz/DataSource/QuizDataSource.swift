protocol QuizDataSourceProtocol {

    func getQuizzes(for category: String) async throws -> [QuizDataModel]

    func getAllQuizzes() async throws -> [QuizDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private var quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizzes(for category: String) async throws -> [QuizDataModel] {
        return try await quizClient.getQuizzes(for: category)
            .map { QuizDataModel(from: $0) }
    }

    func getAllQuizzes() async throws -> [QuizDataModel] {
        return try await quizClient.getAllQuizzes()
            .map { QuizDataModel(from: $0) }
    }

}
