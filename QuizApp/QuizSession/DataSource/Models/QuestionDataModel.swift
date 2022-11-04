struct QuestionDataModel {

    let id: Int
    let answers: [AnswerDataModel]
    let correctAnswerId: Int
    let question: String

    init(from model: QuestionResponseModel) {
        id = model.id
        answers = model.answers.map { AnswerDataModel(from: $0) }
        correctAnswerId = model.correctAnswerId
        question = model.question
    }

}
