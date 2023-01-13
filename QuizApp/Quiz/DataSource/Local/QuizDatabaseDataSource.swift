import Foundation
import RealmSwift

protocol QuizDatabaseDataSourceProtocol {

    func getAllQuizzes() -> [QuizDataObject]

    func getQuizzes(for category: String) -> [QuizDataObject]

    func saveQuizzes(quizzes: [QuizDataObject])

}

class QuizDatabaseDataSource: QuizDatabaseDataSourceProtocol {

    private let realmQueue = DispatchQueue(label: "thread.realm")

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

        realmQueue.async {
            print(Thread.current)
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
    }

    private func instantiateRealm() {
        realmQueue.async {
            do {
                print(Thread.current)
                self.realm = try Realm(queue: self.realmQueue)
            } catch {
                print("Error opening Realm: ", error)
            }
        }
    }

}
