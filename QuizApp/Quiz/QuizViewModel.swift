class QuizViewModel {

    var mockQuizzes: [QuizModel] = []

    private var router: AppRouterProtocol

    let quizzes: [QuizModel] = [
        QuizModel(category: "GEOGRAPHY",
                  description: "Geography Quiz description that can usually span over multiple lines",
                  difficulty: "EASY", id: 1, imageUrl: "", name: "Earth", numberOfQuestions: 8),
        QuizModel(category: "MOVIES",
                  description: "Movie Quiz description that can usually span over multiple lines",
                  difficulty: "NORMAL", id: 2, imageUrl: "", name: "Movie1", numberOfQuestions: 8),
        QuizModel(category: "MUSIC",
                  description: "Music Quiz description that can usually span over multiple lines",
                  difficulty: "EASY", id: 3, imageUrl: "", name: "Songs", numberOfQuestions: 8),
        QuizModel(category: "SPORT",
                  description: "Sport Quiz description that can usually span over multiple lines",
                  difficulty: "HARD", id: 4, imageUrl: "", name: "Football", numberOfQuestions: 8),
        QuizModel(category: "MOVIES",
                  description: "Movie Quiz description that can usually span over multiple lines",
                  difficulty: "HARD", id: 5, imageUrl: "", name: "Movie2", numberOfQuestions: 8),
        QuizModel(category: "SPORT",
                  description: "Movie Quiz description that can usually span over multiple lines",
                  difficulty: "EASY", id: 6, imageUrl: "", name: "Movie2", numberOfQuestions: 8),
        QuizModel(category: "GEOGRAPHY",
                  description: "Movie Geography description that can usually span over multiple lines",
                  difficulty: "NORMAL", id: 7, imageUrl: "", name: "Mars", numberOfQuestions: 8)]

    init(router: AppRouterProtocol) {
        self.router = router
    }

    func getAllQuizzes() {
        mockQuizzes.removeAll()
        mockQuizzes = quizzes
    }
    func getQuizzes(for category: String) {
        mockQuizzes.removeAll()
        mockQuizzes = quizzes.filter { $0.category == category }
    }

}
