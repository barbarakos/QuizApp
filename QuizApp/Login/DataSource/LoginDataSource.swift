import Foundation

protocol LoginDataSourceProtocol {

    func login(username: String, password: String) async throws -> LoginDataModel

    func checkAccessToken() async throws

}

class LoginDataSource: LoginDataSourceProtocol {

    private var loginClient: LoginClientProtocol

    init(loginClient: LoginClientProtocol) {
        self.loginClient = loginClient
    }

    func login(username: String, password: String) async throws -> LoginDataModel {
        return LoginDataModel(from: try await loginClient.login(password: password, username: username))
    }

    func checkAccessToken() async throws {
        try await loginClient.checkAccessToken()
    }

}
