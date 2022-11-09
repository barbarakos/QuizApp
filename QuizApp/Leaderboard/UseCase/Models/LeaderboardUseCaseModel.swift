struct LeaderboardUseCaseModel {

    let name: String
    let points: Int

}

extension LeaderboardUseCaseModel {

    init(from model: LeaderboardDataModel) {
        name = model.name
        points = model.points
    }

}
