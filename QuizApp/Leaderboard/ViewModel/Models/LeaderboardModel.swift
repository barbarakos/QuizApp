struct LeaderboardModel: Hashable {

    let index: Int
    let name: String
    let points: Int

}

extension LeaderboardModel {

    init(from model: LeaderboardUseCaseModel, index: Int) {
        self.index = index
        name = model.name
        points = model.points
    }

}
