import UIKit

enum CategorySection: String, CaseIterable {

    case geography = "Geography"
    case movies = "Movies"
    case music = "Music"
    case sport = "Sport"

    var color: UIColor {
        switch self {
        case .geography:
            return  UIColor.systemGreen
        case .movies:
            return UIColor.systemYellow
        case .music:
            return UIColor.systemRed
        case .sport:
            return UIColor.systemBlue
        }
    }

}
