struct QuestionUseCaseModel {

    let answers: [AnswerUseCaseModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

    init(from dataSourceModel: QuestionDataSourceModel) {
        self.answers = dataSourceModel.answers.map { AnswerUseCaseModel(from: $0) }
        self.correctAnswerId = dataSourceModel.correctAnswerId
        self.id = dataSourceModel.id
        self.question = dataSourceModel.question
    }

}
