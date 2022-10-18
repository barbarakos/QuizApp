import Foundation

protocol UserDatasourceProtocol {

    func getUser(accessToken: String) async throws -> UserResponseModel

    func changeName(name: String, accessToken: String) async throws

}

class UserDatasource: UserDatasourceProtocol {

    private var userClient: UserClientProtocol

    init(userClient: UserClientProtocol) {
        self.userClient = userClient
    }

    func getUser(accessToken: String) async throws -> UserResponseModel {
        return try await userClient.getUser(accessToken: accessToken)
    }

    func changeName(name: String, accessToken: String) async throws {
        try await userClient.changeName(name: name, accessToken: accessToken)
    }

}
