import Foundation

protocol LoginDataSourceProtocol {

    func login(username: String, password: String) async throws -> LoginDataModel

    func checkAccessToken() async throws

}

class LoginDataSource: LoginDataSourceProtocol {

    private var loginClient: LoginClientProtocol
    private var storage: SecureStorageProtocol

    init(storage: SecureStorageProtocol, loginClient: LoginClientProtocol) {
        self.storage = storage
        self.loginClient = loginClient
    }

    func login(username: String, password: String) async throws -> LoginDataModel {
        return LoginDataModel(from: try await loginClient.login(password: password, username: username))
    }

    func checkAccessToken() async throws {
        try await loginClient.checkAccessToken(accessToken: storage.accessToken ?? "")
    }

}
