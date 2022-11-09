import Foundation

protocol QuizSessionDataSourceProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionDataModel

}

class QuizSessionDataSource: QuizSessionDataSourceProtocol {

    private let quizSessionClient: QuizSessionClientProtocol
    private let storage: SecureStorageProtocol

    init(storage: SecureStorageProtocol, quizSessionClient: QuizSessionClientProtocol) {
        self.storage = storage
        self.quizSessionClient = quizSessionClient
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionDataModel {
        guard let accessToken = storage.accessToken else {
            throw RequestError.dataError
        }

        return QuizSessionDataModel(from: try await quizSessionClient.fetchQuestions(
                                                            quizId: quizId,
                                                            accessToken: accessToken))
    }

}
