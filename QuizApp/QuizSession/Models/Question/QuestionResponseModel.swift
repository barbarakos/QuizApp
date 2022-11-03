struct QuestionResponseModel: Decodable {

    let answers: [AnswerResponseModel]
    let correctAnswerId: Int
    let id: Int
    let question: String

}
