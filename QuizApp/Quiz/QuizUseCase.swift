protocol QuizUseCaseProtocol {

    func getQuizzes(for category: String) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private var dataSource: QuizDataSourceProtocol
    private var tokenStorage: SecureStorage

    init(tokenStorage: SecureStorage, dataSource: QuizDataSourceProtocol) {
        self.tokenStorage = tokenStorage
        self.dataSource = dataSource
    }

    func getQuizzes(for category: String) async throws -> [QuizModel] {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await dataSource.getQuizzes(for: category, accessToken: accessToken)
    }

}
