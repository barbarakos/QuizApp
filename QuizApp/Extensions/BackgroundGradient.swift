import UIKit

class BackgroundGradient: CAGradientLayer {

    func setBackground() {
        colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        locations = [0, 1]
        startPoint = CGPoint(x: 0.5, y: 0.25)
        endPoint = CGPoint(x: 0.5, y: 0.85)
        type = .axial
    }

}
