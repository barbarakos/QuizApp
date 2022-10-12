import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

class LoginUseCase: LoginUseCaseProtocol {

    private var datasource: LoginDatasource!
    private var tokenStorage: SecureStorage!

    init(tokenStorage: SecureStorage) {
        self.tokenStorage = tokenStorage
        self.datasource = LoginDatasource(storage: tokenStorage)
    }

    func login(username: String, password: String) async throws {
        let response = try await datasource.login(username: username, password: password)
        print(response.accessToken)
        tokenStorage.save(accessToken: response.accessToken)
    }

}
