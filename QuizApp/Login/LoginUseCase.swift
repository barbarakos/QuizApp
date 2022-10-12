import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws
    
}

class LoginUseCase {

    private var datasource = LoginDatasource()
    private var tokenStorage: SecureStorage!

    convenience init(tokenStorage: SecureStorage) {
        self.init()
        self.tokenStorage = tokenStorage
    }

    func login(username: String, password: String) async throws {
        let response = try await datasource.login(username: username, password: password)
        print(response.accessToken)
        tokenStorage.save(accessToken: response.accessToken)
    }

}
