import Foundation

protocol QuizRepositoryProtocol {

    func getQuizzes(for category: String) async throws -> [QuizDataModel]

    func getAllQuizzes() async throws -> [QuizDataModel]

}

class QuizRepository: QuizRepositoryProtocol {

    private var localDataSource: RealmDataSourceProtocol
    private var remoteDataSource: QuizDataSourceProtocol

    init(localDataSource: RealmDataSourceProtocol, remoteDataSource: QuizDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    @MainActor
    func getQuizzes(for category: String) async throws -> [QuizDataModel] {
        do {
            let quizzes = try await remoteDataSource.getQuizzes(for: category)
            localDataSource.saveQuizzes(quizzes)
            return quizzes
        } catch RequestError.serverError {
            let quizzes = localDataSource.getQuizzes(for: category)
            return quizzes
        } catch let error {
            throw error
        }
    }

    @MainActor
    func getAllQuizzes() async throws -> [QuizDataModel] {
        do {
            let quizzes = try await remoteDataSource.getAllQuizzes()
            localDataSource.saveQuizzes(quizzes)
            return quizzes
        } catch RequestError.serverError {
            let quizzes = localDataSource.getAllQuizzes()
            return quizzes
        } catch let error {
            throw error
        }
    }

}
