class QuizResultViewModel {

    let numberOfCorrectQuestions: Int
    let numberOfQuestions: Int

    private let router: AppRouterProtocol

    init(router: AppRouterProtocol, result: Result) {
        self.router = router
        self.numberOfCorrectQuestions = result.numOfCorrectQuestions
        self.numberOfQuestions = result.numOfQuestions
    }

    func finishQuiz() {
        router.showTabBarControllers()
    }

}
