import Factory
import UIKit

extension Container {

    static let appRouter = Factory(scope: .singleton) {
        AppRouter() as AppRouterProtocol
    }

    static let tokenStorage = Factory(scope: .singleton) {
        SecureStorage() as SecureStorageProtocol
    }

    static let apiClient = Factory(scope: .singleton) {
        ApiClient(storage: tokenStorage()) as ApiClientProtocol
    }

}

// MARK: Login
extension Container {

    static let loginClient = Factory(scope: .singleton) {
        LoginClient(apiClient: apiClient()) as LoginClientProtocol
    }

    static let loginDataSource = Factory(scope: .singleton) {
        LoginDataSource(loginClient: loginClient()) as LoginDataSourceProtocol
    }

    static let loginUseCase = Factory(scope: .singleton) {
        LoginUseCase(tokenStorage: tokenStorage(), dataSource: loginDataSource()) as LoginUseCaseProtocol
    }

    static let loginViewModel = Factory {
        LoginViewModel(router: appRouter(), useCase: loginUseCase()) as LoginViewModel
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
        UserUseCase(dataSource: userDataSource()) as UserUseCaseProtocol
    }

    static let userViewModel = Factory {
        UserViewModel(router: appRouter(), tokenStorage: tokenStorage(), useCase: userUseCase()) as UserViewModel
    }

    static let userViewController = Factory {
        UserViewController(viewModel: userViewModel()) as UserViewController
    }

    static let userView = Factory {
        UserView(viewModel: userViewModel()) as UserView
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
        QuizUseCase(dataSource: quizDataSource()) as QuizUseCaseProtocol
    }

    static let quizViewModel = Factory {
        QuizViewModel(router: appRouter(), useCase: quizUseCase()) as QuizViewModel
    }

    static let quizViewController = Factory {
        QuizViewController(viewModel: quizViewModel()) as QuizViewController
    }

    static let quizListView = Factory {
        QuizListView(viewModel: quizViewModel()) as QuizListView
    }

}

// MARK: QuizDetails
extension Container {

    static let quizDetailsViewModel = ParameterFactory<QuizModel, QuizDetailsViewModel> { quiz in
        QuizDetailsViewModel(router: appRouter(), quiz: quiz) as QuizDetailsViewModel
    }

    static let quizDetailsViewController = ParameterFactory<QuizModel, QuizDetailsViewController> { quiz in
        QuizDetailsViewController(viewModel: quizDetailsViewModel(quiz)) as QuizDetailsViewController
    }

}

// MARK: Quiz leaderboard
extension Container {

    static let leaderboardClient = Factory(scope: .singleton) {
        LeaderboardClient(apiClient: apiClient()) as LeaderboardClientProtocol
    }

    static let leaderboardDataSource = Factory(scope: .singleton) {
        LeaderboardDataSource(
            leaderboardClient: leaderboardClient()) as LeaderboardDataSourceProtocol
    }

    static let leaderboardUseCase = Factory(scope: .singleton) {
        LeaderboardUseCase(leaderboardDataSource: leaderboardDataSource()) as LeaderboardUseCaseProtocol
    }

    static let leaderboardViewModel = ParameterFactory<Int, LeaderboardViewModel> { quizId in
        LeaderboardViewModel(router: appRouter(), leaderboardUseCase: leaderboardUseCase(), quizId: quizId)
    }

    static let leaderboardViewController = ParameterFactory<Int, LeaderboardViewController> { quizId in
        LeaderboardViewController(viewModel: leaderboardViewModel(quizId))
    }

}

// MARK: QuizSession
extension Container {

    static let quizSessionClient = Factory(scope: .singleton) {
        QuizSessionClient(apiClient: apiClient()) as QuizSessionClientProtocol
    }

    static let quizSessionDataSource = Factory(scope: .singleton) {
        QuizSessionDataSource(
            quizSessionClient: quizSessionClient()) as QuizSessionDataSourceProtocol
    }

    static let quizSessionUseCase = Factory(scope: .singleton) {
        QuizSessionUseCase(quizSessionDataSource: quizSessionDataSource()) as QuizSessionUseCaseProtocol
    }

}

// MARK: SearchController
extension Container {

    static let searchViewController = Factory {
        SearchViewController(viewModel: quizViewModel()) as SearchViewController
    }

}
