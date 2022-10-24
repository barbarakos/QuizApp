import Factory

extension Container {

    static let apiClient = Factory(scope: .singleton) {
        ApiClient() as ApiClientProtocol
    }
    static let tokenStorage = Factory(scope: .singleton) {
        SecureStorage() as SecureStorageProtocol
    }

    static let loginClient = Factory(scope: .singleton) {
        LoginClient(apiClient: apiClient()) as LoginClientProtocol
    }
    static let loginDataSource = Factory(scope: .singleton) {
        LoginDataSource(storage: tokenStorage(), loginClient: loginClient()) as LoginDataSourceProtocol
    }
    static let loginUseCase = Factory(scope: .singleton) {
        LoginUseCase(tokenStorage: tokenStorage(), dataSource: loginDataSource()) as LoginUseCaseProtocol
    }

    static let userClient = Factory(scope: .singleton) {
        UserClient(apiClient: apiClient()) as UserClientProtocol
    }
    static let userDataSource = Factory(scope: .singleton) {
        UserDataSource(userClient: userClient()) as UserDataSourceProtocol
    }
    static let userUseCase = Factory(scope: .singleton) {
        UserUseCase(tokenStorage: tokenStorage(), dataSource: userDataSource()) as UserUseCaseProtocol
    }

    static let quizClient = Factory(scope: .singleton) {
        QuizClient(apiClient: apiClient()) as QuizClientProtocol
    }
    static let quizDataSource = Factory(scope: .singleton) {
        QuizDataSource(quizClient: quizClient()) as QuizDataSourceProtocol
    }
    static let quizUseCase = Factory(scope: .singleton) {
        QuizUseCase(tokenStorage: tokenStorage(), dataSource: quizDataSource()) as QuizUseCaseProtocol
    }

}
