import Foundation

protocol UserDataSourceProtocol {

    func getUser() async throws -> UserDataModel

    func changeName(name: String) async throws

}

class UserDataSource: UserDataSourceProtocol {

    private var userClient: UserClientProtocol

    init(userClient: UserClientProtocol) {
        self.userClient = userClient
    }

    func getUser() async throws -> UserDataModel {
        return UserDataModel(from: try await userClient.getUser())
    }

    func changeName(name: String) async throws {
        try await userClient.changeName(name: name)
    }

}
