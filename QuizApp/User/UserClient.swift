import Foundation

protocol UserClientProtocol {

    func getUser(accessToken: String) async throws -> UserResponseModel

}

class UserClient: UserClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let userPath = "api/v1/account"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getUser(accessToken: String) async throws -> UserResponseModel {
        guard let URL = URL(string: "\(baseURL)\(userPath)") else {
            throw RequestError.invalidURL
        }

        var URLrequest = URLRequest(url: URL)
        URLrequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLrequest.httpMethod = "GET"

        return try await apiClient.executeURLRequest(URLRequest: URLrequest)
    }

}
