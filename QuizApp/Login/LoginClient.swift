import Foundation

protocol LoginClientProtocol {

    func login(password: String, username: String) async throws -> LoginResponseModel

    func checkAccessToken(accessToken: String) async throws

}

class LoginClient: LoginClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let loginPath = "api/v1/login"
    let checkPath = "api/v1/check"

    private let apiClient: ApiClientProtocol!

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func login(password: String, username: String) async throws -> LoginResponseModel {
        guard let URL = URL(string: "\(baseURL)\(loginPath)") else {
            throw RequestError.invalidURL
        }

        var URLRequest = URLRequest(url: URL)
        URLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLRequest.httpMethod =  "POST"
        URLRequest.httpBody = try? JSONEncoder().encode(LoginRequestModel(password: password, username: username))

        return try await apiClient.executeURLRequest(URLRequest: URLRequest)
    }

    func checkAccessToken(accessToken: String) async throws {
        guard let URL = URL(string: "\(baseURL)\(checkPath)") else {
            throw RequestError.invalidURL
        }

        var URLRequest = URLRequest(url: URL)
        URLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLRequest.httpMethod = "GET"

        try await apiClient.executeURLRequest(URLRequest: URLRequest)
    }

}
