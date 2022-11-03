struct AnswerModel {

    let answer: String
    let id: Int

    init(from useCaseModel: AnswerUseCaseModel) {
        self.answer = useCaseModel.answer
        self.id = useCaseModel.id
    }

}
