struct QuestionModel {

    let id: Int
    let answers: [AnswerModel]
    let correctAnswerId: Int
    let question: String

}

extension QuestionModel {

    init(from model: QuestionUseCaseModel) {
        id = model.id
        answers = model.answers.map { AnswerModel(from: $0) }
        correctAnswerId = model.correctAnswerId
        question = model.question
    }

}
