protocol QuizUseCaseProtocol {

    func getQuizzes(for category: String) async throws -> [QuizModel]
    func getAllQuizzes() async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private var dataSource: QuizDataSourceProtocol
    private var tokenStorage: SecureStorageProtocol

    init(tokenStorage: SecureStorageProtocol, dataSource: QuizDataSourceProtocol) {
        self.tokenStorage = tokenStorage
        self.dataSource = dataSource
    }

    func getQuizzes(for category: String) async throws -> [QuizModel] {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await dataSource.getQuizzes(for: category, accessToken: accessToken)
    }

    func getAllQuizzes() async throws -> [QuizModel] {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await dataSource.getAllQuizzes(accessToken: accessToken)
    }

}
