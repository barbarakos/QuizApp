enum DifficultyDataModel {

    case easy
    case normal
    case hard

}

extension DifficultyDataModel {

    init(from model: DifficultyResponseModel) {
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
