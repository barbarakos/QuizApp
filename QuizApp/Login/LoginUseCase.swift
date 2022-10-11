import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws
    
}

class LoginUseCase {

    private var datasource = LoginDatasource()

    func login(username: String, password: String) async throws {
        let response = try await datasource.login(username: username, password: password)
        // spremanje response.accesstoken za buduce requestove
    }

}
