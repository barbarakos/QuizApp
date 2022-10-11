import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn(in window: UIWindow?) {
        let viewModel = LoginViewModel(router: self)
        let vc = LoginViewController(viewModel: viewModel)

        navigationController.pushViewController(vc, animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
