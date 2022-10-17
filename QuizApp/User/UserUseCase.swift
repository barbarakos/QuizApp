import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserResponseModel

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

}
