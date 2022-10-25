import Combine

class QuizViewModel {

    @Published var errorOccurred: Bool = false
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
                quizzes = fetchedQuizzes
                errorOccurred = false
            } catch {
                quizzes.removeAll()
                errorOccurred = true
            }
        }
    }

    @MainActor
    func getQuizzes(for category: String) {
        Task {
            do {
                let fetchedQuizzes: [QuizModel] = try await useCase.getQuizzes(for: category)
                quizzes = fetchedQuizzes
                errorOccurred = false
            } catch {
                quizzes.removeAll()
                errorOccurred = true
            }
        }
    }

}
