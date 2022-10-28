import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserResponseModel

    func changeName(name: String) async throws

}

class UserUseCase: UserUseCaseProtocol {

    private var dataSource: UserDataSourceProtocol
    private var tokenStorage: SecureStorage

    init(tokenStorage: SecureStorage, dataSource: UserDataSourceProtocol) {
        self.tokenStorage = tokenStorage
        self.dataSource = dataSource
    }

    func getUser() async throws -> UserResponseModel {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await dataSource.getUser(accessToken: accessToken)
    }

    func changeName(name: String) async throws {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        try await dataSource.changeName(name: name, accessToken: accessToken)
    }

}
