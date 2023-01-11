protocol QuizUseCaseProtocol {

    func getQuizzes(for category: String) async throws -> [QuizUseCaseModel]

    func getAllQuizzes() async throws -> [QuizUseCaseModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private var repository: QuizRepositoryProtocol

    init(repository: QuizRepositoryProtocol) {
        self.repository = repository
    }

    func getQuizzes(for category: String) async throws -> [QuizUseCaseModel] {
        return try await repository.getQuizzes(for: category)
            .map { QuizUseCaseModel(from: $0) }
    }

    func getAllQuizzes() async throws -> [QuizUseCaseModel] {
        return try await repository.getAllQuizzes()
            .map { QuizUseCaseModel(from: $0) }
    }

}
