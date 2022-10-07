import Foundation

class LoginDatasource {

    private var loginClient = LoginClient()

    func login(username: String, password: String) async throws -> LoginResponseModel {
        let response: LoginResponseModel = try await loginClient.login(password: password, username: username)
        return response
    }

}
