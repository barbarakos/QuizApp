import Foundation

protocol LoginClientProtocol {

    func login(password: String, username: String) async throws -> LoginResponseModel

    func checkAccessToken(accessToken: String) async throws

}

class LoginClient: LoginClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let loginPath = "api/v1/login"
    let checkPath = "api/v1/check"

    private let apiClient = ApiClient()

    func login(password: String, username: String) async throws -> LoginResponseModel {
        guard let URL = URL(string: "\(baseURL)\(loginPath)") else {
            throw RequestError.invalidURL
        }

        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLrequest.httpMethod =  "POST"
        URLrequest.httpBody = try? JSONEncoder().encode(LoginRequestModel(password: password, username: username))

        return try await apiClient.executeURLRequest(URLrequest: URLrequest)
    }

    func checkAccessToken(accessToken: String) async throws {
        guard let URL = URL(string: "\(baseURL)\(checkPath)") else {
            throw RequestError.invalidURL
        }

        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLrequest.httpMethod = "GET"

        try await apiClient.executeURLRequest(URLrequest: URLrequest)
    }

}
