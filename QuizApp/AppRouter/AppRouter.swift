import Combine
import SwiftUI
import UIKit
import Factory
import SnapKit

class AppRouter: AppRouterProtocol {

    private let navigationController: UINavigationController

    private var cancellables = Set<AnyCancellable>()

    init() {
        navigationController = UINavigationController()
        editNavBar()
        setNetworkView()
    }

    func start(in window: UIWindow?) {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func showLogIn() {
        navigationController.setViewControllers([Container.loginView()], animated: true)
    }

    func showTabBarControllers() {
        let vc = UIHostingController(rootView: TabBarView(
            quizListView: Container.quizListView(),
            searchView: Container.searchView(),
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
        let vc = Container.quizSessionView(quiz)
        vc.navigationItem.titleView = getTitleLabel("Pop Quiz")
        navigationController.pushViewController(vc, animated: false)
    }

    func showQuizResult(result: Result) {
        let vc = Container.quizResultView(result)

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

    private func setNetworkView() {
        Container.network()
            .$isConnected
            .sink { [weak self] isConnected in
                guard let self = self, !isConnected else { return }

                let hostingController = UIHostingController(rootView: NoInternetView())
                self.navigationController.view.addSubview(hostingController.view)

                hostingController.view.layer.cornerRadius = 30
                hostingController.view.backgroundColor = UIColor.white.withAlphaComponent(0.7)
                hostingController.view.snp.makeConstraints {
                    $0.centerX.equalToSuperview()
                    $0.bottom.equalToSuperview().inset(100)
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    hostingController.view.removeFromSuperview()
                }
            }
            .store(in: &cancellables)
    }

}
