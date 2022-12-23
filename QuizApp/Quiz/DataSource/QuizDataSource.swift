protocol QuizDataSourceProtocol {

    func getQuizzes(for category: String) async throws -> [QuizDataModel]

    func getAllQuizzes() async throws -> [QuizDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private var quizClient: QuizClientProtocol
    private var databaseManager: RealmManagerProtocol

    init(quizClient: QuizClientProtocol, databaseManager: RealmManagerProtocol) {
        self.quizClient = quizClient
        self.databaseManager = databaseManager
    }

    @MainActor
    func getQuizzes(for category: String) async throws -> [QuizDataModel] {
        do {
            let quizzes = try await quizClient.getQuizzes(for: category).map { QuizDataModel(from: $0) }
            databaseManager.saveQuizzes(quizzes: quizzes.map { QuizDataObject(from: $0) })
            return quizzes
        } catch RequestError.serverError {
            let quizzes = databaseManager.getQuizzes(for: category).map { QuizDataModel(from: $0) }
            return quizzes
        } catch let error {
            throw error
        }
    }

    @MainActor
    func getAllQuizzes() async throws -> [QuizDataModel] {
        do {
            let quizzes = try await quizClient.getAllQuizzes().map { QuizDataModel(from: $0) }
            databaseManager.saveQuizzes(quizzes: quizzes.map { QuizDataObject(from: $0) })
            return quizzes
        } catch RequestError.serverError {
            let quizzes = databaseManager.getAllQuizzes().map { QuizDataModel(from: $0) }
            return quizzes
        } catch let error {
            throw error
        }
    }

}
