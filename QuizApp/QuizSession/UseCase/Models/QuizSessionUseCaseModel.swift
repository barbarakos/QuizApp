struct QuizSessionUseCaseModel {

    let sessionId: String
    let questions: [QuestionUseCaseModel]

}

extension QuizSessionUseCaseModel {

    init(from model: QuizSessionDataModel) {
        sessionId = model.sessionId
        questions = model.questions.map { QuestionUseCaseModel(from: $0) }
    }

}
