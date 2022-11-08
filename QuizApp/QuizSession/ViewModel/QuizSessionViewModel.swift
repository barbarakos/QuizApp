import Combine
import UIKit

class QuizSessionViewModel {

    @Published var questions: [QuestionModel] = []
    var quiz: QuizModel
    var currentQuestionIndex: Int = 0

    private let router: AppRouterProtocol
    private let useCase: QuizSessionUseCaseProtocol

    init(router: AppRouterProtocol, quizSessionUseCase: QuizSessionUseCaseProtocol, quiz: QuizModel) {
        self.router = router
        self.useCase = quizSessionUseCase
        self.quiz = quiz
        fetchQuestions()
    }

    func fetchQuestions() {
        Task {
            do {
                let quizSession = QuizSessionModel(from: try await useCase.fetchQuestions(quizId: quiz.id))
                DispatchQueue.main.async { [weak self] in
                    self?.questions = quizSession.questions
                }
            } catch {
                print(error)
            }
        }
    }

    func nextQuestion() -> QuestionModel {
        currentQuestionIndex += 1
        return questions[currentQuestionIndex]
    }

}
