struct QuizDataModel {

    let id: Int
    let category: String
    let description: String
    let difficulty: DifficultyDataModel
    let imageUrl: String
    let name: String
    let numberOfQuestions: Int

}

extension QuizDataModel {

    init(from model: QuizResponseModel) {
        id = model.id
        category = model.category
        description = model.description
        difficulty = DifficultyDataModel(from: model.difficulty)
        imageUrl = model.imageUrl
        name = model.name
        numberOfQuestions = model.numberOfQuestions
    }

    init(from model: QuizDataObject) {
        id = model.id
        category = model.category
        description = model.quizDescription
        difficulty = model.difficulty
        imageUrl = model.imageUrl
        name = model.name
        numberOfQuestions = model.numberOfQuestions
    }

}
