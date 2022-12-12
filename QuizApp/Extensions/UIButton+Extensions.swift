import UIKit

class IdentifiableButton: UIButton {

    var id: Int = 0

    convenience init(id: Int) {
        self.init()

        self.id = id
    }

}
