import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

class LoginUseCase: LoginUseCaseProtocol {

    private var datasource: LoginDatasourceProtocol
    private var tokenStorage: SecureStorage

    init(tokenStorage: SecureStorage, datasource: LoginDatasourceProtocol) {
        self.tokenStorage = tokenStorage
        self.datasource = datasource
    }

    func login(username: String, password: String) async throws {
        let response = try await datasource.login(username: username, password: password)
        print(response.accessToken)
        tokenStorage.save(accessToken: response.accessToken)
    }

}
