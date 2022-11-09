import Foundation

protocol LeaderboardClientProtocol {

    func fetchLeaderboard(accessToken: String, quizId: Int) async throws -> [LeaderboardResponseModel]

}

class LeaderboardClient: LeaderboardClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let leaderboardPath = "api/v1/quiz/leaderboard"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchLeaderboard(accessToken: String, quizId: Int) async throws -> [LeaderboardResponseModel] {
        guard var URL = URL(string: "\(baseURL)\(leaderboardPath)") else {
            throw RequestError.invalidURL
        }

        URL.append(queryItems: [URLQueryItem(name: "quizId", value: String(quizId))])
        var URLRequest = URLRequest(url: URL)
        URLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLRequest.httpMethod = "GET"

        return try await apiClient.executeURLRequest(URLRequest: URLRequest)
    }

}
