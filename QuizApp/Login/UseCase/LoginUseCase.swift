import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

class LoginUseCase: LoginUseCaseProtocol {

    private var dataSource: LoginDataSourceProtocol
    private var tokenStorage: SecureStorage

    init(tokenStorage: SecureStorage, dataSource: LoginDataSourceProtocol) {
        self.tokenStorage = tokenStorage
        self.dataSource = dataSource
    }

    func login(username: String, password: String) async throws {
        let response = try await dataSource.login(username: username, password: password)
        tokenStorage.save(accessToken: response.accessToken)
    }

}
