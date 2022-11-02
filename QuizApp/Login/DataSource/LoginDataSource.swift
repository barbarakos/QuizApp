import Foundation

protocol LoginDataSourceProtocol {

    func login(username: String, password: String) async throws -> LoginDataSourceModel

    func checkAccessToken() async throws

}

class LoginDataSource: LoginDataSourceProtocol {

    private var loginClient: LoginClientProtocol
    private var storage: SecureStorageProtocol

    init(storage: SecureStorageProtocol, loginClient: LoginClientProtocol) {
        self.storage = storage
        self.loginClient = loginClient
    }

    func login(username: String, password: String) async throws -> LoginDataSourceModel {
        let model = LoginDataSourceModel(from: try await loginClient.login(password: password, username: username))
        return model
    }

    func checkAccessToken() async throws {
        try await loginClient.checkAccessToken(accessToken: storage.accessToken ?? "")
    }

}
