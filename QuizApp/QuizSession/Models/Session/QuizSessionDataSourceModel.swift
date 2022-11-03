struct QuizSessionDataSourceModel {

    let questions: [QuestionDataSourceModel]
    let sessionId: String

    init(from responseModel: QuizSessionResponseModel) {
        self.sessionId = responseModel.sessionId
        self.questions = responseModel.questions.map { QuestionDataSourceModel(from: $0) }
    }

}
