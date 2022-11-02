struct QuizUseCaseModel {

    let category: String
    let description: String
    let difficulty: String
    let id: Int
    let imageUrl: String
    let name: String

    init(from dataSourceModel: QuizDataSourceModel) {
        self.category = dataSourceModel.category
        self.description = dataSourceModel.description
        self.difficulty = dataSourceModel.difficulty
        self.id = dataSourceModel.id
        self.imageUrl = dataSourceModel.imageUrl
        self.name = dataSourceModel.name
    }

}
