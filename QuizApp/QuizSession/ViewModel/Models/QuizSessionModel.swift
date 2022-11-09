struct QuizSessionModel {

    let sessionId: String
    let questions: [QuestionModel]

    init(from model: QuizSessionUseCaseModel) {
        sessionId = model.sessionId
        questions = model.questions.map { QuestionModel(from: $0) }
    }

}
