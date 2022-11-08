struct AnswerModel {

    let id: Int
    let answer: String

}

extension AnswerModel {

    init(from model: AnswerUseCaseModel) {
        id = model.id
        answer = model.answer
    }

}
