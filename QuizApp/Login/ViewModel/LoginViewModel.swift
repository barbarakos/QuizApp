import Foundation

class LoginViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var loginFieldsValid: Bool = false
    @Published var err: ValidationError?

    private var useCase: LoginUseCaseProtocol
    private var router: AppRouterProtocol

    init(router: AppRouterProtocol, useCase: LoginUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

    @MainActor
    func login() {
        Task {
            do {
                try await useCase.login(username: username, password: password)
                self.router.showTabBarControllers()
            } catch {
                err = ValidationError.noAccount
            }
        }
    }

}
