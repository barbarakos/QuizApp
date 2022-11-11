import Combine
import UIKit

class LeaderboardViewModel {

    @Published var leaderboard: [LeaderboardModel] = []

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
                    leaderboard = fetched.map { LeaderboardModel(from: $0) }
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
