import Foundation
import UIKit

class UserViewController: UIViewController {

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
