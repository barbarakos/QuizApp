import UIKit
import Factory

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }

    @MainActor
    func showLogIn() {
        navigationController.setViewControllers([Container.loginViewController()], animated: true)
    }

    @MainActor
    func showTabBarControllers() {
        let userVC = Container.userViewController()
        userVC.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill"))

        let quizVC = Container.quizViewController()
        quizVC.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(systemName: "stopwatch"),
            selectedImage: UIImage(systemName: "stopwatch.fill"))

        let viewControllers: [UIViewController] = [quizVC, userVC]
        let tabBarController = TabBarController(viewControllers)
        tabBarController.selectedViewController = viewControllers[0]

        navigationController.setViewControllers([tabBarController], animated: true)
    }

}
