import Foundation
import RealmSwift

enum DifficultyDataObject: String, PersistableEnum {

    case easy
    case normal
    case hard

}

extension DifficultyDataObject {

    init(from model: DifficultyRepoModel) {
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
