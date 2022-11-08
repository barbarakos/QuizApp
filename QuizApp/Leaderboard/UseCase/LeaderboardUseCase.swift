protocol LeaderboardUseCaseProtocol {

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardUseCaseModel]

}

class LeaderboardUseCase: LeaderboardUseCaseProtocol {

    private let leaderboardDataSource: LeaderboardDataSourceProtocol

    init(leaderboardDataSource: LeaderboardDataSourceProtocol) {
        self.leaderboardDataSource = leaderboardDataSource
    }

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardUseCaseModel] {
        try await leaderboardDataSource.fetchLeaderboard(quizId: quizId)
            .map { LeaderboardUseCaseModel(from: $0) }
    }

}
