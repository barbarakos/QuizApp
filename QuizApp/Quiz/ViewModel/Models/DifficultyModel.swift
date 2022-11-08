enum DifficultyModel {

    case easy
    case normal
    case hard

}

extension DifficultyModel {

    init(from model: DifficultyUseCaseModel) {
        switch model {
        case .easy:
            self = .easy
        case .normal:
            self = .normal
        case .hard:
            self = .hard
        }
    }

}
