import Foundation

class LoginUseCase {

    private var datasource = LoginDatasource()
    private var tokenStorage: SecureStorage!

    convenience init(tokenStorage: SecureStorage) {
        self.init()
        self.tokenStorage = tokenStorage
    }

    func login(username: String, password: String) async throws {
        let response = try await datasource.login(username: username, password: password)
        tokenStorage.save(accessToken: response.accesToken)
    }

}
