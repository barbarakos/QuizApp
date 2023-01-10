protocol QuizUseCaseProtocol {

    func getQuizzes(for category: String) async throws -> [QuizUseCaseModel]
    func getAllQuizzes() async throws -> [QuizUseCaseModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private var dataSource: QuizDataSourceProtocol

    init(dataSource: QuizDataSourceProtocol) {
        self.dataSource = dataSource
    }

    @MainActor
    func getQuizzes(for category: String) async throws -> [QuizUseCaseModel] {
        return try await dataSource.getQuizzes(for: category)
            .map { QuizUseCaseModel(from: $0) }
    }

    @MainActor
    func getAllQuizzes() async throws -> [QuizUseCaseModel] {
        return try await dataSource.getAllQuizzes()
            .map { QuizUseCaseModel(from: $0) }
    }

}
