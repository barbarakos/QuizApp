struct QuizSessionResponseModel: Decodable {

    let questions: [QuestionResponseModel]
    let sessionId: String

}
