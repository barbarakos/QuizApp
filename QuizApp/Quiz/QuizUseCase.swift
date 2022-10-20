protocol QuizUseCaseProtocol {

    func getQuizzes(for category: String) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private var datasource: QuizDatasourceProtocol
    private var tokenStorage: SecureStorage

    init(tokenStorage: SecureStorage, datasource: QuizDatasourceProtocol) {
        self.tokenStorage = tokenStorage
        self.datasource = datasource
    }

    func getQuizzes(for category: String) async throws -> [QuizModel] {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await datasource.getQuizzes(for: category, accessToken: accessToken)
    }

}
