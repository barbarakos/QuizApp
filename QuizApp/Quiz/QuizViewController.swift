import Foundation
import UIKit

class QuizViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {}
    func styleViews() {}
    func defineLayoutForViews() {}

}
