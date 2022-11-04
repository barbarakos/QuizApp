struct AnswerDataModel {

    let id: Int
    let answer: String

}

extension AnswerDataModel {

    init(from model: AnswerResponseModel) {
        id = model.id
        answer = model.answer
    }

}
