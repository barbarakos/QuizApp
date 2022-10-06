import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn(in window: UIWindow?) {
        let vc = LoginViewController(router: self)

        navigationController.pushViewController(vc, animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
