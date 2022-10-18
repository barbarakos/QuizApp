import Foundation
import Combine

class QuizViewModel {

    @Published var mockQuizzes: [QuizModel] = []

    private var router: AppRouterProtocol

    let quizzes: [QuizModel] = [
        QuizModel(category: "GEOGRAPHY",
                  description: "Geography Quiz description that can usually span over multiple lines",
                  difficulty: "EASY", id: 0, imageUrl: "", name: "Earth", numberOfQuestions: 8),
        QuizModel(category: "MOVIES",
                  description: "Movie Quiz description that can usually span over multiple lines",
                  difficulty: "MEDIUM", id: 0, imageUrl: "", name: "Movie1", numberOfQuestions: 8),
        QuizModel(category: "MUSIC",
                  description: "Music Quiz description that can usually span over multiple lines",
                  difficulty: "EASY", id: 0, imageUrl: "", name: "Songs", numberOfQuestions: 8),
        QuizModel(category: "SPORT",
                  description: "Sport Quiz description that can usually span over multiple lines",
                  difficulty: "HARD", id: 0, imageUrl: "", name: "Football", numberOfQuestions: 8),
        QuizModel(category: "MOVIES",
                  description: "Movie Quiz description that can usually span over multiple lines",
                  difficulty: "HARD", id: 0, imageUrl: "", name: "Movie2", numberOfQuestions: 8),
        QuizModel(category: "SPORT",
                  description: "Movie Quiz description that can usually span over multiple lines",
                  difficulty: "EASY", id: 0, imageUrl: "", name: "Movie2", numberOfQuestions: 8),
        QuizModel(category: "GEOGRAPHY",
                  description: "Movie Geography description that can usually span over multiple lines",
                  difficulty: "MEDIUM", id: 0, imageUrl: "", name: "Geography2", numberOfQuestions: 8)]

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
