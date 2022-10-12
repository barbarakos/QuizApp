import Foundation

protocol LoginDatasourceProtocol {

    func login(username: String, password: String) async throws -> LoginResponseModel
    func checkAccessToken() async throws

}

class LoginDatasource: LoginDatasourceProtocol {

    private var loginClient: LoginClient!
    private var storage: SecureStorage!

    init(storage: SecureStorage) {
        self.storage = storage
        self.loginClient = LoginClient()
    }

    func login(username: String, password: String) async throws -> LoginResponseModel {
        return try await loginClient.login(password: password, username: username)
    }

    func checkAccessToken() async throws {
        try await loginClient.checkAccessToken(accessToken: storage.accessToken ?? "")
    }

}
