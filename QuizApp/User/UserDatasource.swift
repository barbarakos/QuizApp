import Foundation

protocol UserDatasourceProtocol {

    func getUser() async throws -> UserResponseModel
    func changeName(name: String) async throws

}

class UserDatasource: UserDatasourceProtocol {

    private var userClient: UserClient!
    private var tokenStorage: SecureStorage!

    init(tokenStorage: SecureStorage) {
        self.userClient = UserClient()
        self.tokenStorage = tokenStorage
    }

    func getUser() async throws -> UserResponseModel {
        return try await userClient.getUser(accessToken: tokenStorage.accessToken ?? "")
    }

    func changeName(name: String) async throws {
        try await userClient.changeName(name: name, accessToken: tokenStorage.accessToken ?? "")
    }

}
