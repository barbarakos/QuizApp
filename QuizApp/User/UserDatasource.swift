import Foundation

protocol UserDatasourceProtocol {

    func getUser(accessToken: String) async throws -> UserResponseModel

}

class UserDatasource: UserDatasourceProtocol {

    private var userClient: UserClient!

    init() {
        self.userClient = UserClient()
    }

    func getUser(accessToken: String) async throws -> UserResponseModel {
        return try await userClient.getUser(accessToken: accessToken)
    }

}
