import Foundation
import RealmSwift

protocol RealmDataSourceProtocol {

    func getAllQuizzes() -> [QuizDataModel]

    func getQuizzes(for category: String) -> [QuizDataModel]

    func saveQuizzes(_ quizzesObjModel: [QuizDataModel])

}

class RealmDataSource: RealmDataSourceProtocol {

    private var realm: Realm?

    init() {
        openRealm()
    }

    func getAllQuizzes() -> [QuizDataModel] {
        guard let realm = realm else { return [] }

        var quizzes = Array(realm.objects(QuizDataObject.self))
        return quizzes.map { QuizDataModel(from: $0) }
    }

    func getQuizzes(for category: String) -> [QuizDataModel] {
        guard let realm = realm else { return [] }

        var quizzes = Array(realm.objects(QuizDataObject.self).where { $0.category == category })
        return quizzes.map { QuizDataModel(from: $0) }
    }

    func saveQuizzes(_ quizzesObjModel: [QuizDataModel]) {
        guard let realm = realm else { return }

        let quizzes = quizzesObjModel.map { QuizDataObject(from: $0) }

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
