import Combine
import SwiftUI

class QuizViewModel: ObservableObject {

    @Published var quizError: ErrorInfo?
    @Published var quizzes: [QuizModel] = []
    @Published var segmentationSelection: String = "All"
    @Published var categories = ["All"] + CategorySection.allCases.map {$0.rawValue}

    private var cancellables = Set<AnyCancellable>()

    private var router: AppRouterProtocol
    private var useCase: QuizUseCaseProtocol

    init(router: AppRouterProtocol, useCase: QuizUseCaseProtocol) {
        self.router = router
        self.useCase = useCase
        subscriptions()
    }

    @MainActor
    func getAllQuizzes() {
        Task {
            do {
                let fetchedQuizzes = try await useCase.getAllQuizzes()
                quizError = fetchedQuizzes.isEmpty ? QuizError.empty.info : nil
                quizzes = fetchedQuizzes.map { QuizModel(from: $0) }
            } catch {
                quizzes.removeAll()
                quizError = QuizError.serverError.info
            }
        }
    }

    @MainActor
    func getQuizzes(for category: String) {
        Task {
            do {
                let fetchedQuizzes = try await useCase.getQuizzes(for: category)
                quizError = fetchedQuizzes.isEmpty ? QuizError.empty.info : nil
                quizzes = fetchedQuizzes.map { QuizModel(from: $0) }
            } catch {
                quizzes.removeAll()
                quizError = QuizError.serverError.info
            }
        }
    }

    func showQuizDetails(quiz: QuizModel) {
        router.showQuizDetails(quiz: quiz)
    }

    private func subscriptions() {
        $segmentationSelection
            .sink { [weak self] selection in
                self?.onSelectionChange(selection: selection)
            }
            .store(in: &cancellables)
    }

    func searchAndFilteredQuizzes(_ searchText: String, _ section: CategorySection) -> [QuizModel] {
        if searchText.isEmpty {
            return quizzes.filter { $0.category == section.rawValue.uppercased() }
        } else {
            let searchedQuizzes = quizzes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
            return searchedQuizzes.filter { $0.category == section.rawValue.uppercased() }
        }
    }

    private func onSelectionChange(selection: String) {
        let allCategories = CategorySection.allCases.map { $0.rawValue }
        if allCategories.contains(selection) {
            DispatchQueue.main.async {
                self.getQuizzes(for: selection.uppercased())
            }
        } else {
            DispatchQueue.main.async {
                self.getAllQuizzes()
            }
        }
    }

}
