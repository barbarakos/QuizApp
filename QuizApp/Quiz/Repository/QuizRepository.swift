import Foundation

protocol QuizRepositoryProtocol {

    func getQuizzes(for category: String) async throws -> [QuizRepoModel]

    func getAllQuizzes() async throws -> [QuizRepoModel]

}

class QuizRepository: QuizRepositoryProtocol {

    private var localDataSource: QuizDatabaseDataSourceProtocol
    private var remoteDataSource: QuizDataSourceProtocol

    init(localDataSource: QuizDatabaseDataSourceProtocol, remoteDataSource: QuizDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func getQuizzes(for category: String) async throws -> [QuizRepoModel] {
        do {
            let quizzes = try await remoteDataSource.getQuizzes(for: category).map { QuizRepoModel(from: $0) }
            localDataSource.saveQuizzes(quizzes: quizzes.map { QuizDataObject(from: $0) })
            return quizzes
        } catch RequestError.serverError {
            return localDataSource.getQuizzes(for: category).map { QuizRepoModel(from: $0) }
        } catch let error {
            throw error
        }
    }

    func getAllQuizzes() async throws -> [QuizRepoModel] {
        do {
            let quizzes = try await remoteDataSource.getAllQuizzes().map { QuizRepoModel(from: $0) }
            localDataSource.saveQuizzes(quizzes: quizzes.map { QuizDataObject(from: $0) })
            return quizzes
        } catch RequestError.serverError {
            return localDataSource.getAllQuizzes().map { QuizRepoModel(from: $0) }
        } catch let error {
            throw error
        }
    }

}
