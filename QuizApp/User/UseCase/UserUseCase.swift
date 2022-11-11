import Foundation

protocol UserUseCaseProtocol {

    func getUser() async throws -> UserUseCaseModel

    func changeName(name: String) async throws

}

class UserUseCase: UserUseCaseProtocol {

    private var dataSource: UserDataSourceProtocol

    init(dataSource: UserDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func getUser() async throws -> UserUseCaseModel {
        return UserUseCaseModel(from: try await dataSource.getUser())
    }

    func changeName(name: String) async throws {
        try await dataSource.changeName(name: name)
    }

}
