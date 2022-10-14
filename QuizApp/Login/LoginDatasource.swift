import Foundation

protocol LoginDatasourceProtocol {

    func login(username: String, password: String) async throws -> LoginResponseModel

}

class LoginDatasource: LoginDatasourceProtocol {

    private var loginClient = LoginClient()

    func login(username: String, password: String) async throws -> LoginResponseModel {
        return try await loginClient.login(password: password, username: username)
    }

}
