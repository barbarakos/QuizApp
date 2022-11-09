struct QuizSessionResponseModel: Decodable {

    let sessionId: String
    let questions: [QuestionResponseModel]

}
