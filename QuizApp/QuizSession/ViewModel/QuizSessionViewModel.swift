import Combine
import UIKit

class QuizSessionViewModel {

    @Published var currentQuestion: QuestionModel!
    var quiz: QuizModel
    var questions: [QuestionModel] = []

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
                    guard let self = self else { return }

                    self.questions = quizSession.questions
                    self.currentQuestion = self.questions[0]
                }
            } catch {
                print(error)
            }
        }
    }

    func nextQuestion() {
        if currentQuestion.index+1 < questions.count {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }

                self.currentQuestion = self.questions[self.currentQuestion.index+1]
            }
        } else {
            // show quiz results
        }
    }

}
