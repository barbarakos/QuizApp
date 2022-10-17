import Foundation

protocol LoginDatasourceProtocol {

    func login(username: String, password: String) async throws -> LoginResponseModel
    
    func checkAccessToken() async throws

}

class LoginDatasource: LoginDatasourceProtocol {

    internal var loginClient: LoginClientProtocol!
    internal var storage: SecureStorage!

    init(storage: SecureStorage, loginClient: LoginClientProtocol) {
        self.storage = storage
        self.loginClient = loginClient
    }

    func login(username: String, password: String) async throws -> LoginResponseModel {
        return try await loginClient.login(password: password, username: username)
    }

    func checkAccessToken() async throws {
        try await loginClient.checkAccessToken(accessToken: storage.accessToken ?? "")
    }

}
