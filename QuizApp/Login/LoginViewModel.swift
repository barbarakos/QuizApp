import Foundation

class LoginViewModel {

    private var useCase: LoginUseCaseProtocol
    private var router: AppRouterProtocol
    private var tokenStorage: SecureStorage

    init(router: AppRouterProtocol, tokenStorage: SecureStorage, useCase: LoginUseCaseProtocol) {
        self.router = router
        self.tokenStorage = tokenStorage
        self.useCase = useCase
    }

    func login(username: String, password: String) {
        Task {
            do {
                try await useCase.login(username: username, password: password)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.router.showTabBarControllers()
                }

            } catch {
                print(error)
            }
        }
    }

}
