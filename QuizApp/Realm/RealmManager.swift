import Foundation
import RealmSwift

protocol RealmManagerProtocol {

    func getAllQuizzes() -> [QuizDataObject]

    func getQuizzes(for category: String) -> [QuizDataObject]

    func saveQuizzes(quizzes: [QuizDataObject])

}

class RealmManager: RealmManagerProtocol {

    private var realm: Realm?

    init() {
        openRealm()
    }

    func getAllQuizzes() -> [QuizDataObject] {
        guard let realm = realm else { return [] }

        return Array(realm.objects(QuizDataObject.self))
    }

    func getQuizzes(for category: String) -> [QuizDataObject] {
        guard let realm = realm else { return [] }

        return Array(realm.objects(QuizDataObject.self).where { $0.category == category })
    }

    func saveQuizzes(quizzes: [QuizDataObject]) {
        guard let realm = realm else { return }

        do {
            try realm.write {
                for quiz in quizzes {
                    realm.add(quiz, update: .modified)
                }
            }
        } catch {
            print("Error adding quiz to Realm ", error)
        }
    }

    private func openRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Error opening Realm: ", error)
        }
    }

}
