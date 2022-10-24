enum CategorySection: String, CaseIterable {

    case main
    case geography = "Geography"
    case movies = "Movies"
    case music = "Music"
    case sport = "Sport"

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
        case .main:
            return "Main"
        }
    }

}
