import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var name: String = ""
    @Published var err: ValidationError?

    private var useCase: UserUseCaseProtocol
    private var router: AppRouterProtocol
    private var tokenStorage: SecureStorageProtocol

    init(router: AppRouterProtocol, tokenStorage: SecureStorageProtocol, useCase: UserUseCaseProtocol) {
        self.router = router
        self.tokenStorage = tokenStorage
        self.useCase = useCase
        getUser()
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
                err = ValidationError.serverError
            }
        }
    }

    func changeName() {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            err = ValidationError.emptyUsername
            getUser()
            return
        }

        Task {
            do {
                try await useCase.changeName(name: name)
            } catch {
                err = ValidationError.serverError
            }
        }
    }

    func logout() {
        tokenStorage.deleteToken()
        router.showLogIn()
    }

}
