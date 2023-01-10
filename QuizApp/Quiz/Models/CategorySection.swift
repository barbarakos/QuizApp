import SwiftUI
import UIKit

enum CategorySection: String, CaseIterable {

    case geography = "Geography"
    case movies = "Movies"
    case music = "Music"
    case sport = "Sport"

    var color: Color {
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
