import Foundation
import Combine

class UserViewModel {

    private var userUseCase: UserUseCase!
    private var router: AppRouterProtocol!
    private var tokenStorage: SecureStorage!

    @Published var username: String!
    @Published var name: String!

    init(router: AppRouterProtocol, tokenStorage: SecureStorage) {
        self.router = router
        self.tokenStorage = tokenStorage

        self.userUseCase = UserUseCase(tokenStorage: tokenStorage)
    }

    func getUser() {
        Task {
            do {
                let user: UserResponseModel = try await userUseCase.getUser()
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.username = user.email
                    self.name = user.name
                }
            } catch {
                print(error)
            }
        }
    }

    func logout() {
        tokenStorage.deleteToken()
        router.showLogIn()
    }

}
