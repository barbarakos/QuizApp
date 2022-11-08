import Combine

class QuizDetailsViewModel {

    @Published var quiz: QuizModel

    private let router: AppRouterProtocol

    init(router: AppRouterProtocol, quiz: QuizModel) {
        self.router = router
        self.quiz = quiz
    }

    func showLeaderboard() {
        router.showLeaderboard(quizId: quiz.id)
    }

    func startQuiz() {
        router.showQuizSession(quiz: quiz)
    }

}
