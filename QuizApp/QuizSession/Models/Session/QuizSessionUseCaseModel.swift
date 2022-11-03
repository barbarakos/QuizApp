struct QuizSessionUseCaseModel {

    let questions: [QuestionUseCaseModel]
    let sessionId: String

    init(from dataSourceModel: QuizSessionDataSourceModel) {
        self.sessionId = dataSourceModel.sessionId
        self.questions = dataSourceModel.questions.map { QuestionUseCaseModel(from: $0) }
    }

}
