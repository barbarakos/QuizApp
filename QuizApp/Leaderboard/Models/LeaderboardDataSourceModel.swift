struct LeaderboardDataSourceModel {

    let name: String
    let points: Int

    init(from response: LeaderboardResponseModel) {
        self.name = response.name
        self.points = response.points
    }

}
