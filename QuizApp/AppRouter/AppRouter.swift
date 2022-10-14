import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    let tokenStorage = SecureStorage()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn() {
        let viewModel = LoginViewModel(router: self, tokenStorage: tokenStorage)
        let vc = LoginViewController(viewModel: viewModel)

        navigationController.setViewControllers([vc], animated: true)
    }

    func showUserVC() {
        let vc = UserViewController()
        navigationController.setViewControllers([vc], animated: true)
    }

}
