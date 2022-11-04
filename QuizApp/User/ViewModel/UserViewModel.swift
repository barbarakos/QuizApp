import Foundation
import Combine

class UserViewModel {

    @Published var username: String!
    @Published var name: String!

    private var useCase: UserUseCaseProtocol
    private var router: AppRouterProtocol
    private var tokenStorage: SecureStorageProtocol

    init(router: AppRouterProtocol, tokenStorage: SecureStorageProtocol, useCase: UserUseCaseProtocol) {
        self.router = router
        self.tokenStorage = tokenStorage
        self.useCase = useCase
    }

    func getUser() {
        Task {
            do {
                let user = UserModel(from: try await useCase.getUser())
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

    func changeName(name: String) {
        Task {
            do {
                try await useCase.changeName(name: name)
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
