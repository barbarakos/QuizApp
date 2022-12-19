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
        vc.navigationItem.titleView = getTitleLabel("Pop Quiz")
        navigationController.setViewControllers([vc], animated: true)
    }

    func showQuizDetails(quiz: QuizModel) {
        let vc = Container.quizDetailView(quiz)
        vc.navigationItem.titleView = getTitleLabel("Pop Quiz")
        navigationController.pushViewController(vc, animated: false)
    }

    func showLeaderboard(quizId: Int) {
        let vc = Container.leaderboardView(quizId)
        vc.navigationItem.titleView = getTitleLabel("Leaderboard")
        navigationController.pushViewController(vc, animated: true)
    }

    func closeLeaderboard() {
        navigationController.popViewController(animated: false)
    }

    func showQuizSession(quiz: QuizModel) {
        let vc = Container.quizSessionViewController(quiz)

        navigationController.pushViewController(vc, animated: false)
    }

    func showQuizResult(result: Result) {
        let vc = Container.quizResultViewController(result)

        navigationController.setViewControllers([vc], animated: false)
    }

    private func editNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
    }

    private func getTitleLabel(_ text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)
        titleLabel.text = text
        titleLabel.textColor = .white
        return titleLabel
    }

}
