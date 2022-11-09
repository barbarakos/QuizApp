struct LeaderboardDataModel {

    let name: String
    let points: Int

}

extension LeaderboardDataModel {

    init(from model: LeaderboardResponseModel) {
        name = model.name
        points = model.points
    }

}
