import Foundation

protocol QuizClientProtocol {

    func getQuizzes(for category: String) async throws -> [QuizResponseModel]
    func getAllQuizzes() async throws -> [QuizResponseModel]

}

class QuizClient: QuizClientProtocol {

    let baseURL = "https://five-ios-api.herokuapp.com/"
    let quizzesPath = "api/v1/quiz/list"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func getQuizzes(for category: String) async throws -> [QuizResponseModel] {
        let path = "\(baseURL)\(quizzesPath)"
        let query = [URLQueryItem(name: "category", value: String(category))]

        return try await apiClient.get(path: path, query: query)
    }

    func getAllQuizzes() async throws -> [QuizResponseModel] {
        let path = "\(baseURL)\(quizzesPath)"

        return try await apiClient.get(path: path, query: nil)
    }

}
