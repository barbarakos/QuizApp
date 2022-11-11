protocol LeaderboardDataSourceProtocol {

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardDataModel]

}

class LeaderboardDataSource: LeaderboardDataSourceProtocol {

    private let leaderboardClient: LeaderboardClientProtocol

    init(leaderboardClient: LeaderboardClientProtocol) {
        self.leaderboardClient = leaderboardClient
    }

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardDataModel] {
        return try await leaderboardClient.fetchLeaderboard(quizId: quizId)
                        .map { LeaderboardDataModel(from: $0) }
    }

}
