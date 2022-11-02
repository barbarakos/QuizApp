import UIKit
import Combine

class LeaderboardViewModel {

    @Published var leaderboard: [LeaderboardResponseModel] = []

    private let router: AppRouterProtocol
    private let leaderboardUseCase: LeaderboardUseCaseProtocol
    private let quizId: Int

    init(router: AppRouterProtocol, leaderboardUseCase: LeaderboardUseCaseProtocol, quizId: Int) {
        self.router = router
        self.leaderboardUseCase = leaderboardUseCase
        self.quizId = quizId

        fetchLeaderboard()
    }

    private func fetchLeaderboard() {
        Task {
            do {
                let fetched = try await leaderboardUseCase.fetchLeaderboard(quizId: quizId)

                await MainActor.run {
                    leaderboard = fetched
                }
            } catch {
                print(error)
            }
        }
    }

    func closeLeaderboard() {
        router.closeLeaderboard()
    }

}
