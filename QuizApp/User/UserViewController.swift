import Foundation
import UIKit

class UserViewController: UIViewController {

    private var router: AppRouterProtocol!

    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        buildViews()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {}
    func styleViews() {}
    func defineLayoutForViews() {}

}
