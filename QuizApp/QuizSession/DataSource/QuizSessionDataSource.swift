import Foundation

protocol QuizSessionDataSourceProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionDataModel

    func endQuiz(sessionId: String, numberOfCorrectQuestions: Int) async throws

}

class QuizSessionDataSource: QuizSessionDataSourceProtocol {

    private let quizSessionClient: QuizSessionClientProtocol

    init(quizSessionClient: QuizSessionClientProtocol) {
        self.quizSessionClient = quizSessionClient
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionDataModel {
        return QuizSessionDataModel(from: try await quizSessionClient.fetchQuestions(quizId: quizId))
    }

    func endQuiz(sessionId: String, numberOfCorrectQuestions: Int) async throws {
         try await quizSessionClient.endQuiz(sessionId: sessionId, numberOfCorrectQuestions: numberOfCorrectQuestions)
    }

}
