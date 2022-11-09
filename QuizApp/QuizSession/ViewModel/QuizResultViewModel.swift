class QuizResultViewModel {

    let numberOfCorrectQuestions: Int
    let numberOfQuestions: Int

    private let router: AppRouterProtocol

    init(router: AppRouterProtocol, numberOfCorrectQuestions: Int, numberOfQuestions: Int) {
        self.router = router
        self.numberOfCorrectQuestions = numberOfCorrectQuestions
        self.numberOfQuestions = numberOfQuestions
    }

    func finishQuiz() {
        router.showTabBarControllers()
    }

}
