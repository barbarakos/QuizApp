struct QuizSessionDataModel {

    let sessionId: String
    let questions: [QuestionDataModel]

}

extension QuizSessionDataModel {

    init(from model: QuizSessionResponseModel) {
        sessionId = model.sessionId
        questions = model.questions.map { QuestionDataModel(from: $0) }
    }

}
