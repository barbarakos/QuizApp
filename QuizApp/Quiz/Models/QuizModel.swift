struct QuizModel {

    let category: String
    let description: String
    let difficulty: String
    let id: Int
    let imageUrl: String
    let name: String

    init(from useCaseModel: QuizUseCaseModel) {
        self.category = useCaseModel.category
        self.description = useCaseModel.description
        self.difficulty = useCaseModel.difficulty
        self.id = useCaseModel.id
        self.imageUrl = useCaseModel.imageUrl
        self.name = useCaseModel.name
    }

}

extension QuizModel: Hashable {

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }

    static func == (lhs: QuizModel, rhs: QuizModel) -> Bool {
      lhs.id == rhs.id
    }

}
