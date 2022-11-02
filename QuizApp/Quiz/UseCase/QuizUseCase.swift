protocol QuizUseCaseProtocol {

    func getQuizzes(for category: String) async throws -> [QuizUseCaseModel]
    func getAllQuizzes() async throws -> [QuizUseCaseModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private var dataSource: QuizDataSourceProtocol
    private var tokenStorage: SecureStorageProtocol

    init(tokenStorage: SecureStorageProtocol, dataSource: QuizDataSourceProtocol) {
        self.tokenStorage = tokenStorage
        self.dataSource = dataSource
    }

    func getQuizzes(for category: String) async throws -> [QuizUseCaseModel] {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await dataSource.getQuizzes(for: category, accessToken: accessToken)
            .map { QuizUseCaseModel(from: $0) }
    }

    func getAllQuizzes() async throws -> [QuizUseCaseModel] {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await dataSource.getAllQuizzes(accessToken: accessToken)
            .map { QuizUseCaseModel(from: $0) }
    }

}
