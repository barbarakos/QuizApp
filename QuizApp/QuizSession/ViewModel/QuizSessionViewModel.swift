import Combine
import UIKit

class QuizSessionViewModel {

    @Published var currentQuestion: QuestionModel!
    var quiz: QuizModel
    var questions: [QuestionModel] = []
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
                    currentQuestion = questions[0]
                }
            } catch {
                print(error)
            }
        }
    }

    func nextQuestion() {
        currentQuestionIndex += 1
        currentQuestion = questions[currentQuestionIndex]
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
