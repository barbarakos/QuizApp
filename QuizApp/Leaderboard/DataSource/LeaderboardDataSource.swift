protocol LeaderboardDataSourceProtocol {

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardResponseModel]

}

class LeaderboardDataSource: LeaderboardDataSourceProtocol {

    private let leaderboardClient: LeaderboardClientProtocol
    private let storage: SecureStorageProtocol

    init(storage: SecureStorageProtocol, leaderboardClient: LeaderboardClientProtocol) {
        self.storage = storage
        self.leaderboardClient = leaderboardClient
    }

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardResponseModel] {
        guard let accessToken = storage.accessToken else {
            throw RequestError.dataError
        }

        return try await leaderboardClient.fetchLeaderboard(accessToken: accessToken, quizId: quizId)
    }

}
