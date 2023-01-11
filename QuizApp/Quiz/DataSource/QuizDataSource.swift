protocol QuizDataSourceProtocol {

    func getQuizzes(for category: String) async throws -> [QuizDataModel]

    func getAllQuizzes() async throws -> [QuizDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private var quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    @MainActor
    func getQuizzes(for category: String) async throws -> [QuizDataModel] {
        do {
            let quizzes = try await quizClient.getQuizzes(for: category).map { QuizDataModel(from: $0) }
            return quizzes
        } catch let error {
            throw error
        }
    }

    @MainActor
    func getAllQuizzes() async throws -> [QuizDataModel] {
        do {
            let quizzes = try await quizClient.getAllQuizzes().map { QuizDataModel(from: $0) }
            return quizzes
        } catch let error {
            throw error
        }
    }

}
