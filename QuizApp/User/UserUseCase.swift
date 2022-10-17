import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserResponseModel

    func changeName(name: String) async throws

}

class UserUseCase: UserUseCaseProtocol {

    internal var datasource: UserDatasourceProtocol!
    internal var tokenStorage: SecureStorage!

    init(tokenStorage: SecureStorage, datasource: UserDatasourceProtocol) {
        self.tokenStorage = tokenStorage
        self.datasource = datasource
    }

    func getUser() async throws -> UserResponseModel {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        return try await datasource.getUser(accessToken: accessToken)
    }

    func changeName(name: String) async throws {
        guard let accessToken = tokenStorage.accessToken else {
            throw RequestError.dataError
        }

        try await datasource.changeName(name: name, accessToken: accessToken)
    }

}
