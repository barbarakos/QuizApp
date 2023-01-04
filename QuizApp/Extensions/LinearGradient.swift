import SwiftUI

extension LinearGradient {

    static var quizAppGradient: LinearGradient {
        let gradient = Gradient(colors: [Color.lightPurple, Color.darkPurple])
        return LinearGradient(gradient: gradient,
                              startPoint: .top,
                              endPoint: .bottom)
    }

}
