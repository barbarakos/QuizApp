import Foundation
import RealmSwift

protocol QuizDatabaseDataSourceProtocol {

    func getAllQuizzes() -> [QuizDataObject]

    func getQuizzes(for category: String) -> [QuizDataObject]

    func saveQuizzes(quizzes: [QuizDataObject])

}

class QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {

    private var realm: Realm?

    init() {
        instantiateRealm()
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

    private func instantiateRealm() {
        do {
            realm = try Realm()
        } catch {
            print("Error opening Realm: ", error)
        }
    }

}
