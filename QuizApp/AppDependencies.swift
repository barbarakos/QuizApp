class AppDependencies {

    lazy var tokenStorage: SecureStorage = {
        SecureStorage()
    }()

    lazy var apiClient: ApiClientProtocol = {
        ApiClient()
    }()

    lazy var loginClient: LoginClientProtocol = {
        LoginClient(apiClient: apiClient)
    }()

    lazy var userClient: UserClientProtocol = {
        UserClient(apiClient: apiClient)
    }()

    lazy var quizClient: QuizClientProtocol = {
        QuizClient(apiClient: apiClient)
    }()

    lazy var loginDataSource: LoginDataSourceProtocol = {
        LoginDataSource(storage: tokenStorage, loginClient: loginClient)
    }()

    lazy var userDataSource: UserDataSourceProtocol = {
        UserDataSource(userClient: userClient)
    }()

    lazy var quizDataSource: QuizDataSourceProtocol = {
        QuizDataSource(quizClient: quizClient)
    }()

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(tokenStorage: tokenStorage, dataSource: loginDataSource)
    }()

    lazy var userUseCase: UserUseCaseProtocol = {
        UserUseCase(tokenStorage: tokenStorage, dataSource: userDataSource)
    }()

    lazy var quizUseCase: QuizUseCaseProtocol = {
        QuizUseCase(tokenStorage: tokenStorage, dataSource: quizDataSource)
    }()

}
