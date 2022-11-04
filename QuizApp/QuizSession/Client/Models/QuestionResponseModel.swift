struct QuestionResponseModel: Decodable {

    let id: Int
    let answers: [AnswerResponseModel]
    let correctAnswerId: Int
    let question: String

}
