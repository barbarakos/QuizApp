import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserUseCaseModel

    func changeName(name: String) async throws

}

class UserUseCase: UserUseCaseProtocol {

    private var dataSource: UserDataSourceProtocol
    private var tokenStorage: SecureStorageProtocol

    init(tokenStorage: SecureStorageProtocol, dataSource: UserDataSourceProtocol) {
        self.tokenStorage = tokenStorage
        self.dataSource = dataSource
    }

    func getUser() async throws -> UserUseCaseModel {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return UserUseCaseModel(from: try await dataSource.getUser(accessToken: accessToken))
    }

    func changeName(name: String) async throws {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        try await dataSource.changeName(name: name, accessToken: accessToken)
    }

}
