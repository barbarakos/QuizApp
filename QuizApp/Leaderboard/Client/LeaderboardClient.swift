import Foundation

protocol LeaderboardClientProtocol {

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardResponseModel]

}

class LeaderboardClient: LeaderboardClientProtocol {

    let baseURL = "https://five-ios-api.herokuapp.com/"
    let leaderboardPath = "api/v1/quiz/leaderboard"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchLeaderboard(quizId: Int) async throws -> [LeaderboardResponseModel] {
        let path = "\(baseURL)\(leaderboardPath)"
        let query = [URLQueryItem(name: "quizId", value: String(quizId))]

        return try await apiClient.get(path: path, query: query)
    }

}
