import Foundation
import UIKit

class SearchViewController: UIViewController {

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

extension SearchViewController: ConstructViewsProtocol {

    func createViews() {}
    func styleViews() {}
    func defineLayoutForViews() {}

}
