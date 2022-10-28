import Factory
import UIKit

extension Container {

    static let appRouter = Factory(scope: .singleton) {
        AppRouter() as AppRouterProtocol
    }

    static let apiClient = Factory(scope: .singleton) {
        ApiClient() as ApiClientProtocol
    }

    static let tokenStorage = Factory(scope: .singleton) {
        SecureStorage() as SecureStorageProtocol
    }

}

// MARK: Login
extension Container {

    static let loginClient = Factory(scope: .singleton) {
        LoginClient(apiClient: apiClient()) as LoginClientProtocol
    }

    static let loginDataSource = Factory(scope: .singleton) {
        LoginDataSource(storage: tokenStorage(), loginClient: loginClient()) as LoginDataSourceProtocol
    }

    static let loginUseCase = Factory(scope: .singleton) {
        LoginUseCase(tokenStorage: tokenStorage(), dataSource: loginDataSource()) as LoginUseCaseProtocol
    }

    static let loginViewModel = Factory {
        LoginViewModel(router: appRouter(), tokenStorage: tokenStorage(), useCase: loginUseCase()) as LoginViewModel
    }

    static let loginViewController = Factory {
        LoginViewController(viewModel: loginViewModel()) as LoginViewController
    }

}

// MARK: User
extension Container {

    static let userClient = Factory(scope: .singleton) {
        UserClient(apiClient: apiClient()) as UserClientProtocol
    }

    static let userDataSource = Factory(scope: .singleton) {
        UserDataSource(userClient: userClient()) as UserDataSourceProtocol
    }

    static let userUseCase = Factory(scope: .singleton) {
        UserUseCase(tokenStorage: tokenStorage(), dataSource: userDataSource()) as UserUseCaseProtocol
    }

    static let userViewModel = Factory {
        UserViewModel(router: appRouter(), tokenStorage: tokenStorage(), useCase: userUseCase()) as UserViewModel
    }

    static let userViewController = Factory {
        UserViewController(viewModel: userViewModel()) as UserViewController
    }

}

// MARK: Quiz
extension Container {

    static let quizClient = Factory(scope: .singleton) {
        QuizClient(apiClient: apiClient()) as QuizClientProtocol
    }

    static let quizDataSource = Factory(scope: .singleton) {
        QuizDataSource(quizClient: quizClient()) as QuizDataSourceProtocol
    }

    static let quizUseCase = Factory(scope: .singleton) {
        QuizUseCase(tokenStorage: tokenStorage(), dataSource: quizDataSource()) as QuizUseCaseProtocol
    }

    static let quizViewModel = Factory {
        QuizViewModel(router: appRouter(), useCase: quizUseCase()) as QuizViewModel
    }

    static let quizViewController = Factory {
        QuizViewController(viewModel: quizViewModel()) as QuizViewController
    }

}
