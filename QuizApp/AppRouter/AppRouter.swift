import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    let tokenStorage = SecureStorage()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @MainActor
    func showLogIn() {
        let viewModel = LoginViewModel(router: self, tokenStorage: tokenStorage)
        let vc = LoginViewController(viewModel: viewModel)

        navigationController.setViewControllers([vc], animated: true)
    }


    @MainActor
    func showTabBarControllers() {
        let userVM = UserViewModel(router: self, tokenStorage: tokenStorage)
        let userVC = UserViewController(viewModel: userVM)

        let searchVC = SearchViewController()
        let quizVC = QuizViewController()

        let viewControllers: [UIViewController] = [quizVC, searchVC, userVC]
        let tabBarController = TabBarController(viewControllers)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

}
