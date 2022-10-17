import Foundation

protocol UserDatasourceProtocol {

    func getUser(accessToken: String) async throws -> UserResponseModel

}

class UserDatasource: UserDatasourceProtocol {

    internal var userClient: UserClientProtocol!

    init(userClient: UserClientProtocol) {
        self.userClient = userClient
    }

    func getUser(accessToken: String) async throws -> UserResponseModel {
        return try await userClient.getUser(accessToken: accessToken)
    }

}
