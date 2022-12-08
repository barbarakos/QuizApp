struct QuestionUseCaseModel: Equatable {

    let id: Int
    let answers: [AnswerUseCaseModel]
    let correctAnswerId: Int
    let question: String

    static func == (lhs: QuestionUseCaseModel, rhs: QuestionUseCaseModel) -> Bool {
        return lhs.id == rhs.id
    }

}

extension QuestionUseCaseModel {

    init(from model: QuestionDataModel) {
        id = model.id
        answers = model.answers.map { AnswerUseCaseModel(from: $0) }
        correctAnswerId = model.correctAnswerId
        question = model.question
    }

}
