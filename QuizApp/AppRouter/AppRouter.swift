import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn() {
        let vc = LoginViewController(router: self)
        navigationController.setViewControllers([vc], animated: true)
//        navigationController.pushViewController(vc, animated: false)
    }

    func showUserVC() {
        let vc = UserViewController(router: self)
        navigationController.setViewControllers([vc], animated: true)
//        navigationController.pushViewController(vc, animated: true)
    }

}
