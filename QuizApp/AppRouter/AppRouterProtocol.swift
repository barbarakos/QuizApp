import UIKit

protocol AppRouterProtocol {

    func start(in window: UIWindow?)

    func showLogIn()

    func showTabBarControllers()

    func showQuizDetails(quiz: QuizModel)

}
