import Foundation

protocol UserClientProtocol {

    func getUser(accessToken: String) async throws -> UserResponseModel
    func changeName(name: String, accessToken: String) async throws

}

class UserClient: UserClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let userPath = "api/v1/account"

    private let apiClient = ApiClient()

    func getUser(accessToken: String) async throws -> UserResponseModel {
        guard let URL = URL(string: "\(baseURL)\(userPath)") else {
            throw RequestError.invalidURL
        }

        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLrequest.httpMethod = "GET"

        return try await apiClient.executeURLRequest(URLrequest: URLrequest)
    }

    func changeName(name: String, accessToken: String) async throws {
        guard let URL = URL(string: "\(baseURL)\(userPath)") else {
            throw RequestError.invalidURL
        }

        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLrequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLrequest.httpMethod = "PATCH"
        URLrequest.httpBody = try? JSONEncoder().encode(UserRequestModel(name: name))

        try await apiClient.executeURLRequest(URLrequest: URLrequest)
    }

}
