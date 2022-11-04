struct LeaderboardModel {

    let name: String
    let points: Int

}

extension LeaderboardModel {

    init(from model: LeaderboardUseCaseModel) {
        name = model.name
        points = model.points
    }

}
