import Combine

class QuizViewModel {

    @Published var quizError: QuizError?
    @Published var quizzes: [QuizModel] = []

    private var router: AppRouterProtocol
    private var useCase: QuizUseCaseProtocol

    init(router: AppRouterProtocol, useCase: QuizUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
    }

    @MainActor
    func getAllQuizzes() {
        Task {
            do {
                let fetchedQuizzes = try await useCase.getAllQuizzes()
                if fetchedQuizzes.isEmpty {
                    quizError = QuizError.empty
                }
                quizzes = fetchedQuizzes
            } catch {
                quizzes.removeAll()
                quizError = QuizError.serverError
            }
        }
    }

    @MainActor
    func getQuizzes(for category: String) {
        Task {
            do {
                let fetchedQuizzes: [QuizModel] = try await useCase.getQuizzes(for: category)
                if fetchedQuizzes.isEmpty {
                    quizError = QuizError.empty
                }
                quizzes = fetchedQuizzes
            } catch {
                quizzes.removeAll()
                quizError = QuizError.serverError
            }
        }
    }

    func showQuizDetails(quiz: QuizModel) {
        router.showQuizDetails(quiz: quiz)
    }

}
