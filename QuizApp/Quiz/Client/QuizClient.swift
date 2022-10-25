import Foundation

protocol QuizClientProtocol {

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizModel]
    func getAllQuizzes(accessToken: String) async throws -> [QuizModel]

}

class QuizClient: QuizClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let quizzesPath = "api/v1/quiz/list"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getQuizzes(for category: String, accessToken: String) async throws -> [QuizModel] {
        guard let URL = URL(string: "\(baseURL)\(quizzesPath)?category=\(category)") else {
            throw RequestError.invalidURL
        }

        var URLRequest = URLRequest(url: URL)
        URLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLRequest.httpMethod = "GET"
        
        return try await apiClient.executeURLRequest(URLRequest: URLRequest)
    }
    
    func getAllQuizzes(accessToken: String) async throws -> [QuizModel] {
        guard let URL = URL(string: "\(baseURL)\(quizzesPath)") else {
            throw RequestError.invalidURL
        }
        
        var URLRequest = URLRequest(url: URL)
        URLRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        URLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        URLRequest.httpMethod = "GET"
        
        return try await apiClient.executeURLRequest(URLRequest: URLRequest)
    }
    
}
