import Foundation
import UIKit

class TabBarController: UITabBarController {

    convenience init(_ viewControllers: [UIViewController]) {
        self.init()

        self.viewControllers = viewControllers
        setupTabBar()
    }

    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
    }

}
