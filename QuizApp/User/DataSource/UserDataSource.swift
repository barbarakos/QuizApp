import Foundation

protocol UserDataSourceProtocol {

    func getUser(accessToken: String) async throws -> UserDataModel

    func changeName(name: String, accessToken: String) async throws

}

class UserDataSource: UserDataSourceProtocol {

    private var userClient: UserClientProtocol

    init(userClient: UserClientProtocol) {
        self.userClient = userClient
    }

    func getUser(accessToken: String) async throws -> UserDataModel {
        return UserDataModel(from: try await userClient.getUser(accessToken: accessToken))
    }

    func changeName(name: String, accessToken: String) async throws {
        try await userClient.changeName(name: name, accessToken: accessToken)
    }

}
