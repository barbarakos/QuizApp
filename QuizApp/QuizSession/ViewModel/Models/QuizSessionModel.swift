struct QuizSessionModel {

    let sessionId: String
    let questions: [QuestionModel]
    
    init(from model: QuizSessionUseCaseModel) {
        sessionId = model.sessionId
        questions = model.questions
            .enumerated()
            .map { index, model in
                QuestionModel(from: model, index: index)
            }
    }

}
