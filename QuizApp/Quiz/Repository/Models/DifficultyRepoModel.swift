import Foundation

enum DifficultyRepoModel {

    case easy
    case normal
    case hard

}

extension DifficultyRepoModel {

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

    init(from model: DifficultyDataObject) {
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
