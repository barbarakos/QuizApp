import SwiftUI

extension LinearGradient {

    static var quizAppGradient: LinearGradient {
        return LinearGradient(gradient:
                                Gradient(colors:
                                            [Color(red: 0.453, green: 0.308, blue: 0.637),
                                             Color(red: 0.154, green: 0.185, blue: 0.463)]),
                              startPoint: .top,
                              endPoint: .bottom)
    }

}
