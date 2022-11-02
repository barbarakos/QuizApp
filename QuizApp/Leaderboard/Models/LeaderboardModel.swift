struct LeaderboardModel {

    let name: String
    let points: Int

    init(from useCaseModel: LeaderboardUseCaseModel) {
        self.name = useCaseModel.name
        self.points = useCaseModel.points
    }

}
