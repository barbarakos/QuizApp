protocol QuizSessionUseCaseProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionUseCaseModel

}

class QuizSessionUseCase: QuizSessionUseCaseProtocol {

    private let quizSessionDataSource: QuizSessionDataSourceProtocol

    init(quizSessionDataSource: QuizSessionDataSourceProtocol) {
        self.quizSessionDataSource = quizSessionDataSource
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionUseCaseModel {
        let quizSession = QuizSessionUseCaseModel(from: try await quizSessionDataSource.fetchQuestions(quizId: quizId))
        return quizSession
    }

}
