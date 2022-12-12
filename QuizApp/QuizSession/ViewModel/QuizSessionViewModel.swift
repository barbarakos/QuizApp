import Combine
import UIKit

class QuizSessionViewModel {

    @Published var currentQuestion: QuestionModel!
    var quiz: QuizModel
    var questions: [QuestionModel] = []

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

    func nextQuestion(numOfCorrectQuestions: Int) {
        if currentQuestion.index+1 < questions.count {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }

                self.currentQuestion = self.questions[self.currentQuestion.index+1]
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }

                self.endQuiz(numOfCorrectQuestions: numOfCorrectQuestions)
                self.goToQuizResult(numOfCorrectQuestions: numOfCorrectQuestions)
            }
        }
    }

    func endQuiz(numOfCorrectQuestions: Int) {
        Task {
            do {
                try await useCase.endQuiz(sessionId: sessionId, numberOfCorrectQuestions: numOfCorrectQuestions)
            } catch {
                print(error)
            }
        }
    }

    func goToQuizResult(numOfCorrectQuestions: Int) {
        router.showQuizResult(result: Result(numOfCorrectQuestions: numOfCorrectQuestions, numOfQuestions: questions.count))
    }

}
