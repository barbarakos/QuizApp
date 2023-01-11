import Foundation
import RealmSwift

class QuizDataObject: Object {

    @Persisted(primaryKey: true) var id: Int
    @Persisted var category: String
    @Persisted var quizDescription: String
    @Persisted var difficulty: DifficultyDataObject
    @Persisted var imageUrl: String
    @Persisted var name: String
    @Persisted var numberOfQuestions: Int

}

extension QuizDataObject {

    convenience init(from quiz: QuizRepoModel) {
        self.init()

        id = quiz.id
        category = quiz.category
        quizDescription = quiz.description
        difficulty = DifficultyDataObject(from: quiz.difficulty)
        imageUrl = quiz.imageUrl
        name = quiz.name
        numberOfQuestions = quiz.numberOfQuestions
    }

}
