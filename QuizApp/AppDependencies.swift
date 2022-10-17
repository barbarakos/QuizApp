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

    lazy var loginDatasource: LoginDatasourceProtocol = {
        LoginDatasource(storage: tokenStorage, loginClient: loginClient)
    }()

    lazy var userDatasource: UserDatasourceProtocol = {
        UserDatasource(userClient: userClient)
    }()

    lazy var loginUseCase: LoginUseCaseProtocol = {
        LoginUseCase(tokenStorage: tokenStorage, datasource: loginDatasource)
    }()

    lazy var userUseCase: UserUseCaseProtocol = {
        UserUseCase(tokenStorage: tokenStorage, datasource: userDatasource)
    }()

}
