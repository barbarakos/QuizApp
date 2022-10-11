import Foundation

class LoginViewModel {

    private var useCase = LoginUseCase()
    private var router: AppRouterProtocol!

    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }

    func login(username: String, password: String) {
        Task {
            do {
                try await useCase.login(username: username, password: password)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.router.showUserVC()
                }

            } catch {
                print(error)
            }
        }
    }

}
