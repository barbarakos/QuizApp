import SwiftUI
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

    var colorSwiftUI: Color {
        switch self {
        case .geography:
            return Color.green
        case .movies:
            return Color.yellow
        case .music:
            return Color.red
        case .sport:
            return Color.blue
        }
    }

}
