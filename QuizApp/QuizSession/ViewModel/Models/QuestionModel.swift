struct QuestionModel {

    let id: Int
    let index: Int
    var answers: [AnswerModel]
    let correctAnswerId: Int
    let question: String

}

extension QuestionModel {

    init(from model: QuestionUseCaseModel, index: Int) {
        id = model.id
        answers = model.answers
            .enumerated()
            .map { index, model in
                AnswerModel(from: model, index: index)
            }
        correctAnswerId = model.correctAnswerId
        question = model.question
        self.index = index
    }

}
