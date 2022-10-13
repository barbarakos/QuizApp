import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserResponseModel
    func changeName(name: String) async throws

}

class UserUseCase: UserUseCaseProtocol {

    private var datasource: UserDatasource!
    private var tokenStorage: SecureStorage!

    init(tokenStorage: SecureStorage) {
        self.tokenStorage = tokenStorage
        self.datasource = UserDatasource(tokenStorage: tokenStorage)
    }

    func getUser() async throws -> UserResponseModel {
        return try await datasource.getUser()
    }

    func changeName(name: String) async throws {
        try await datasource.changeName(name: name)
    }

}
