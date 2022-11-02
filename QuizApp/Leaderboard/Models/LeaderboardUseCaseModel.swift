struct LeaderboardUseCaseModel {

    let name: String
    let points: Int

    init(from dataSourceModel: LeaderboardDataSourceModel) {
        self.name = dataSourceModel.name
        self.points = dataSourceModel.points
    }

}
