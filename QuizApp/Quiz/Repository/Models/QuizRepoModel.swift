struct QuizRepoModel {

    let id: Int
    let category: String
    let description: String
    let difficulty: DifficultyRepoModel
    let imageUrl: String
    let name: String
    let numberOfQuestions: Int

}

extension QuizRepoModel {

    init(from model: QuizDataModel) {
        id = model.id
        category = model.category
        description = model.description
        difficulty = DifficultyRepoModel(from: model.difficulty)
        imageUrl = model.imageUrl
        name = model.name
        numberOfQuestions = model.numberOfQuestions
    }

    init(from model: QuizDataObject) {
        id = model.id
        category = model.category
        description = model.quizDescription
        difficulty = DifficultyRepoModel(from: model.difficulty)
        imageUrl = model.imageUrl
        name = model.name
        numberOfQuestions = model.numberOfQuestions
    }

}
