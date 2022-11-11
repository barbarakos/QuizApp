import Foundation

protocol QuizSessionDataSourceProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionDataModel

}

class QuizSessionDataSource: QuizSessionDataSourceProtocol {

    private let quizSessionClient: QuizSessionClientProtocol

    init(quizSessionClient: QuizSessionClientProtocol) {
        self.quizSessionClient = quizSessionClient
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionDataModel {
        return QuizSessionDataModel(from: try await quizSessionClient.fetchQuestions(quizId: quizId))
    }

}
