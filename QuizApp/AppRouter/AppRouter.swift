import UIKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController!
    private let appDependencies: AppDependencies!

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    @MainActor
    func showLogIn() {
        let viewModel = LoginViewModel(router: self, tokenStorage: appDependencies.tokenStorage,
                                       useCase: appDependencies.loginUseCase)
        let vc = LoginViewController(viewModel: viewModel)

        navigationController.setViewControllers([vc], animated: true)
    }

    @MainActor
    func showTabBarControllers() {
        let userVM = UserViewModel(router: self, tokenStorage: appDependencies.tokenStorage,
                                   useCase: appDependencies.userUseCase)
        let userVC = UserViewController(viewModel: userVM)
        userVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"),
                                         selectedImage: UIImage(systemName: "gearshape.fill"))

        let quizVC = QuizViewController()
        quizVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "stopwatch"),
                                         selectedImage: UIImage(systemName: "stopwatch.fill"))

        let viewControllers: [UIViewController] = [quizVC, userVC]
        let tabBarController = TabBarController(viewControllers)
        tabBarController.selectedViewController = viewControllers[1]

        navigationController.setViewControllers([tabBarController], animated: true)
    }

}
