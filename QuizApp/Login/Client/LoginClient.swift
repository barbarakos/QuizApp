import Foundation

protocol LoginClientProtocol {

    func login(password: String, username: String) async throws -> LoginResponseModel

    func checkAccessToken() async throws

}

class LoginClient: LoginClientProtocol {

    let baseURL = "https://five-ios-api.herokuapp.com/"
    let loginPath = "api/v1/login"
    let checkPath = "api/v1/check"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func login(password: String, username: String) async throws -> LoginResponseModel {
        let path = "\(baseURL)\(loginPath)"
        let body = ["password": password, "username": username]

        return try await apiClient.post(path: path, body: body)
    }

    func checkAccessToken() async throws {
        let path = "\(baseURL)\(checkPath)"

        try await apiClient.get(path: path)
    }

}
