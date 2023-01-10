import Combine
import SwiftUI
import UIKit

class QuizSessionViewModel: ObservableObject {

    @Published var currentQuestion: QuestionModel?
    var questionNumberLabel: String = ""
    var quiz: QuizModel

    private let router: AppRouterProtocol
    private let useCase: QuizSessionUseCaseProtocol

    private var cancellables = Set<AnyCancellable>()
    private var questions: [QuestionModel] = []

    private var sessionId: String!

    init(router: AppRouterProtocol, quizSessionUseCase: QuizSessionUseCaseProtocol, quiz: QuizModel) {
        self.router = router
        self.useCase = quizSessionUseCase
        self.quiz = quiz
        fetchQuestions()
        setBindings()
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
        guard let currQuestion = currentQuestion else { return }

        if currQuestion.index+1 < questions.count {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }

                self.currentQuestion = self.questions[currQuestion.index+1]
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
        router.showQuizResult(
            result: Result(numOfCorrectQuestions: numOfCorrectQuestions, numOfQuestions: questions.count))
    }

    private func setBindings() {
        $currentQuestion
            .compactMap { $0 }
            .sink { [weak self] currentQuestion in
                guard let self = self else { return }

                self.questionNumberLabel = "\(currentQuestion.index + 1)/\(self.quiz.numberOfQuestions)"
            }
            .store(in: &cancellables)
    }

}
