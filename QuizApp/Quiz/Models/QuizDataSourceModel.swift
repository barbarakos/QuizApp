struct QuizDataSourceModel {

    let category: String
    let description: String
    let difficulty: String
    let id: Int
    let imageUrl: String
    let name: String

    init(from responseModel: QuizResponseModel) {
        self.category = responseModel.category
        self.description = responseModel.description
        self.difficulty = responseModel.difficulty
        self.id = responseModel.id
        self.imageUrl = responseModel.imageUrl
        self.name = responseModel.name
    }

}
