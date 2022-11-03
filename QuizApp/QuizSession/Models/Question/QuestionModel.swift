struct QuestionModel {

    let answers: [AnswerModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

    init(from useCaseModel: QuestionUseCaseModel) {
        self.answers = useCaseModel.answers.map { AnswerModel(from: $0) }
        self.correctAnswerId = useCaseModel.correctAnswerId
        self.id = useCaseModel.id
        self.question = useCaseModel.question
    }

}
