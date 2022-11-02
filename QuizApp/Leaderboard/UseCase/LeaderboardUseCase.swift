protocol LeaderboardUseCaseProtocol {

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardResponseModel]

}

class LeaderboardUseCase: LeaderboardUseCaseProtocol {

    private let leaderboardDataSource: LeaderboardDataSourceProtocol

    init(leaderboardDataSource: LeaderboardDataSourceProtocol) {
        self.leaderboardDataSource = leaderboardDataSource
    }

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardResponseModel] {
        try await leaderboardDataSource.fetchLeaderboard(quizId: quizId)
    }

}
