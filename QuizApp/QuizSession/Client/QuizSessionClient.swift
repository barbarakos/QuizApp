import Foundation

protocol QuizSessionClientProtocol {

    func fetchQuestions(quizId: Int, accessToken: String) async throws -> QuizSessionResponseModel

}

class QuizSessionClient: QuizSessionClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let quizPath = "api/v1/quiz/"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchQuestions(quizId: Int, accessToken: String) async throws -> QuizSessionResponseModel {
        guard let URL = URL(string: "\(baseURL)\(quizPath)\(quizId)/session/start") else {
            throw RequestError.invalidURL
        }

        var URLRequest = URLRequest(url: URL)
        URLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLRequest.httpMethod = "POST"

        return try await apiClient.executeURLRequest(URLRequest: URLRequest)
    }

}
