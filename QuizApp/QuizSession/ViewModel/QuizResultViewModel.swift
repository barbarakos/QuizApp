import SwiftUI

class QuizResultViewModel: ObservableObject {

    @Published var result: String

    private let router: AppRouterProtocol

    init(router: AppRouterProtocol, result: Result) {
        self.router = router
        self.result = "\(result.numOfCorrectQuestions)/\(result.numOfQuestions)"
    }

    func finishQuiz() {
        router.showTabBarControllers()
    }

}
