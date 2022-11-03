struct AnswerUseCaseModel {

    let answer: String
    let id: Int

    init(from dataSourceModel: AnswerDataSourceModel) {
        self.answer = dataSourceModel.answer
        self.id = dataSourceModel.id
    }

}
