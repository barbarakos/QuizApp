struct AnswerUseCaseModel {

    let id: Int
    let answer: String

}

extension AnswerUseCaseModel {

    init(from model: AnswerDataModel) {
        id = model.id
        answer = model.answer
    }

}
