import UIKit

enum CategorySection: String, CaseIterable {

    case geography
    case movies
    case music
    case sport

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

    var title: String {
        switch self {
        case .geography:
            return "Geography"
        case .movies:
            return "Movies"
        case .music:
            return "Music"
        case .sport:
            return "Sport"
        }
    }

}
