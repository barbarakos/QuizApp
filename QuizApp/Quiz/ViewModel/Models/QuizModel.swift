struct QuizModel {

    let id: Int
    let category: String
    let description: String
    let difficulty: DifficultyModel
    let imageUrl: String
    let name: String

}

extension QuizModel: Hashable {

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: QuizModel, rhs: QuizModel) -> Bool {
      lhs.id == rhs.id
    }

}

extension QuizModel {

    init(from model: QuizUseCaseModel) {
        id = model.id
        category = model.category
        description = model.description
        difficulty = DifficultyModel(from: model.difficulty)
        imageUrl = model.imageUrl
        name = model.name
    }

}
