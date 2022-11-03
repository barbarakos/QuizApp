struct QuestionDataSourceModel {

    let answers: [AnswerDataSourceModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

    init(from responseModel: QuestionResponseModel) {
        self.answers = responseModel.answers.map { AnswerDataSourceModel(from: $0) }
        self.correctAnswerId = responseModel.correctAnswerId
        self.id = responseModel.id
        self.question = responseModel.question
    }

}
