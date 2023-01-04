import Foundation

protocol UserClientProtocol {

    func getUser() async throws -> UserResponseModel

    func changeName(name: String) async throws

}

class UserClient: UserClientProtocol {

    let baseURL = "https://five-ios-api.herokuapp.com/"
    let userPath = "api/v1/account"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getUser() async throws -> UserResponseModel {
        let path = "\(baseURL)\(userPath)"

        return try await apiClient.get(path: path, query: nil)
    }

    func changeName(name: String) async throws {
        let path = "\(baseURL)\(userPath)"
        let body = ["name": name]

        try await apiClient.patch(path: path, body: body)
    }

}
