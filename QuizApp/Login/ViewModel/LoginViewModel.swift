import Foundation

class LoginViewModel {

    private var useCase: LoginUseCaseProtocol
    private var router: AppRouterProtocol

    init(router: AppRouterProtocol, useCase: LoginUseCaseProtocol) {
        self.router = router
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
