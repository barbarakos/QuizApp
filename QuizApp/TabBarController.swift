import Foundation
import UIKit

class TabBarController: UITabBarController {
//    var viewControllers: [UIViewController]!

    convenience init(_ viewControllers: [UIViewController]) {
        self.init()
        self.viewControllers = viewControllers
        setupTabBar()
    }

    func setupTabBar() {

        self.viewControllers![0].tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "stopwatch"), selectedImage: UIImage(systemName: "stopwatch.fill"))
        self.viewControllers![1].tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        self.viewControllers![2].tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))

        self.tabBar.backgroundColor = .white
        self.selectedViewController = viewControllers![2]
        self.tabBar.tintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
    }

}
