import UIKit

class Button: UIButton {

    var id: Int = 0

    convenience init(id: Int) {
        self.init()

        self.id = id
    }

    override var intrinsicContentSize: CGSize {
            let labelSize = titleLabel?.sizeThatFits(CGSize(
                                        width: frame.size.width,
                                        height: CGFloat.greatestFiniteMagnitude)) ?? .zero
            let desiredButtonSize = CGSize(width: labelSize.width + 30, height: labelSize.height + 40)

            return desiredButtonSize
        }

}
