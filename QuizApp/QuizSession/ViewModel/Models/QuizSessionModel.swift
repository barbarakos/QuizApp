struct QuizSessionModel {

    let sessionId: String
    let questions: [QuestionModel]

    init(from model: QuizSessionUseCaseModel) {
        sessionId = model.sessionId
        questions = model.questions.map { (ucModel) -> QuestionModel in
            QuestionModel(
                from: ucModel,
                index: model.questions.enumerated()
                    .first(where: { $0.element == ucModel})
                    .map { $0.offset }!)}
    }

}
