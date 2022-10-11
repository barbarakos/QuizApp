import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    let tokenStorage = SecureStorage()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn(in window: UIWindow?) {
        let viewModel = LoginViewModel(router: self, tokenStorage: tokenStorage)
        let vc = LoginViewController(viewModel: viewModel)

        navigationController.pushViewController(vc, animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
