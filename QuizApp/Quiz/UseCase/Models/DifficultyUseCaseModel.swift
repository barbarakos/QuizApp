enum DifficultyUseCaseModel {

    case easy
    case normal
    case hard

}

extension DifficultyUseCaseModel {

    init(from model: DifficultyDataModel) {
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
