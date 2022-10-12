import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserResponseModel

}

class UserUseCase: UserUseCaseProtocol {

    private var datasource: UserDatasource!
    private var tokenStorage: SecureStorage!

    init(tokenStorage: SecureStorage) {
        self.tokenStorage = tokenStorage
        self.datasource = UserDatasource()
    }

    func getUser() async throws -> UserResponseModel {
        return try await datasource.getUser(accessToken: tokenStorage.accessToken ?? "")
    }

}
