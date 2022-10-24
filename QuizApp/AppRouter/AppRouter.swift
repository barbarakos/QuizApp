import UIKit
import Factory

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    @MainActor
    func showLogIn() {
        let viewModel = LoginViewModel(
            router: self,
            tokenStorage: Container.tokenStorage(),
            useCase: Container.loginUseCase())

        let vc = LoginViewController(viewModel: viewModel)

        navigationController.setViewControllers([vc], animated: true)
    }

    @MainActor
    func showTabBarControllers() {
        let userVM = UserViewModel(
            router: self,
            tokenStorage: Container.tokenStorage(),
            useCase: Container.userUseCase())

        let userVC = UserViewController(viewModel: userVM)
        userVC.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill"))

        let quizVM = QuizViewModel(router: self, useCase: Container.quizUseCase())
        let quizVC = QuizViewController(viewModel: quizVM)
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
