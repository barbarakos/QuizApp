import Foundation

class LoginViewModel {

    private var useCase: LoginUseCase!
    private var router: AppRouterProtocol!
    private var tokenStorage: SecureStorage!

    convenience init(router: AppRouterProtocol, tokenStorage: SecureStorage) {
        self.router = router
        self.tokenStorage = tokenStorage
        self.useCase = LoginUseCase(tokenStorage: tokenStorage)
    }

    func login(username: String, password: String) {
        Task {
            do {
                try await useCase.login(username: username, password: password)
                // show home screen
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
