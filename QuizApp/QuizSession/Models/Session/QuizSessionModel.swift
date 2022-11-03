struct QuizSessionModel {

    let questions: [QuestionModel]
    let sessionId: String

    init(from useCaseModel: QuizSessionUseCaseModel) {
        self.sessionId = useCaseModel.sessionId
        self.questions = useCaseModel.questions.map { QuestionModel(from: $0) }
    }

}
