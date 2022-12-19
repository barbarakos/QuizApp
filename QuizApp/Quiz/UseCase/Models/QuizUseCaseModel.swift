struct QuizUseCaseModel {

    let id: Int
    let category: String
    let description: String
    let difficulty: DifficultyUseCaseModel
    let imageUrl: String
    let name: String
    let numberOfQuestions: Int

}

extension QuizUseCaseModel {

    init(from model: QuizDataModel) {
        id = model.id
        category = model.category
        description = model.description
        difficulty = DifficultyUseCaseModel(from: model.difficulty)
        imageUrl = model.imageUrl
        name = model.name
        numberOfQuestions = model.numberOfQuestions
    }

}
