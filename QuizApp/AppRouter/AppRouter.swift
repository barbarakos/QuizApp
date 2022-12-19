import SwiftUI
import UIKit
import Factory

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()
        editNavBar()
    }

    func start(in window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func showLogIn() {
        navigationController.setViewControllers([Container.loginViewController()], animated: true)
    }

    func showTabBarControllers() {
        let vc = UIHostingController(rootView: TabBarView(
            quizListView: Container.quizListView(),
            userView: Container.userView()))
        navigationController.setViewControllers([vc], animated: true)
    }

    func showQuizDetails(quiz: QuizModel) {
        let vc = Container.quizDetailView(quiz)

        navigationController.pushViewController(vc, animated: false)
    }

    func showLeaderboard(quizId: Int) {
        let vc = Container.leaderboardViewController(quizId)

        navigationController.pushViewController(vc, animated: true)
    }

    func closeLeaderboard() {
        navigationController.popViewController(animated: false)
    }

    func showQuizSession(quiz: QuizModel) {
        let vc = Container.quizSessionViewController(quiz)

        navigationController.pushViewController(vc, animated: false)
    }

    private func editNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
    }

    func showQuizResult(result: Result) {
        let vc = Container.quizResultViewController(result)

        navigationController.setViewControllers([vc], animated: false)
    }

}
