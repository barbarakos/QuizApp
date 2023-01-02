import Foundation

protocol QuizSessionClientProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionResponseModel

    func endQuiz(sessionId: String, numberOfCorrectQuestions: Int) async throws

}

class QuizSessionClient: QuizSessionClientProtocol {

    let baseURL = "https://five-ios-api.herokuapp.com/"
    let quizPath = "api/v1/quiz/"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionResponseModel {
        let path = "\(baseURL)\(quizPath)\(quizId)/session/start"

        return try await apiClient.post(path: path, body: nil)
    }

    func endQuiz(sessionId: String, numberOfCorrectQuestions: Int) async throws {
        let path = "\(baseURL)\(quizPath)session/\(sessionId)/end"
        let body = ["numberOfCorrectQuestions": String(numberOfCorrectQuestions)]

        try await apiClient.post(path: path, body: body)
    }

}
