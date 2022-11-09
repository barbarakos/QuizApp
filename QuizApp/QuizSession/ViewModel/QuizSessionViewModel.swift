import Combine
import UIKit

class QuizSessionViewModel {

    @Published var questions: [QuestionModel] = []
    var quiz: QuizModel
    var currentQuestionIndex: Int = 0

    private let router: AppRouterProtocol
    private let useCase: QuizSessionUseCaseProtocol

    private var sessionId: String!

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

                await MainActor.run {
                    questions = quizSession.questions
                    sessionId = quizSession.sessionId
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

    func endQuiz(numberOfCorrectQuestions: Int) {
        Task {
            do {
                try await useCase.endQuiz(sessionId: sessionId, numberOfCorrectQuestions: numberOfCorrectQuestions)
            } catch {
                print(error)
            }
        }
    }

    func goToQuizResult(numberOfCorrectQuestions: Int) {
        router.showQuizResult(numOfCorrectQuestions: numberOfCorrectQuestions, numOfQuestions: questions.count)
    }

}
