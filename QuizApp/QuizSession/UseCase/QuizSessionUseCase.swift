protocol QuizSessionUseCaseProtocol {

    func fetchQuestions(quizId: Int) async throws -> QuizSessionUseCaseModel

    func endQuiz(sessionId: String, numberOfCorrectQuestions: Int) async throws

}

class QuizSessionUseCase: QuizSessionUseCaseProtocol {

    private let quizSessionDataSource: QuizSessionDataSourceProtocol

    init(quizSessionDataSource: QuizSessionDataSourceProtocol) {
        self.quizSessionDataSource = quizSessionDataSource
    }

    func fetchQuestions(quizId: Int) async throws -> QuizSessionUseCaseModel {
        return QuizSessionUseCaseModel(from: try await quizSessionDataSource.fetchQuestions(quizId: quizId))
    }

    func endQuiz(sessionId: String, numberOfCorrectQuestions: Int) async throws {
        try await quizSessionDataSource.endQuiz(
            sessionId: sessionId,
            numberOfCorrectQuestions: numberOfCorrectQuestions)
    }

}
