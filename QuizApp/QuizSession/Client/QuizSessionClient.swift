import Foundation

protocol QuizSessionClientProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionResponseModel

}

class QuizSessionClient: QuizSessionClientProtocol {

    let baseURL = "https://five-ios-quiz-app.herokuapp.com/"
    let quizPath = "api/v1/quiz/"

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionResponseModel {
        let path = "\(baseURL)\(quizPath)\(quizId)/session/start"

        return try await apiClient.post(path: path, body: nil)
    }

}
