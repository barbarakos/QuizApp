struct AnswerDataSourceModel {

    let answer: String
    let id: Int

    init(from responseModel: AnswerResponseModel) {
        self.answer = responseModel.answer
        self.id = responseModel.id
    }

}
