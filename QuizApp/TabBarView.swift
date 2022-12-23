import SwiftUI
import Factory

struct TabBarView: View {

    @State private var selection = 0

    private var quizView: QuizView!
    private var userView: UserView!

    init(quizView: QuizView, userView: UserView) {
        self.quizView = quizView
        self.userView = userView
    }

    var body: some View {
        TabView(selection: $selection) {
            quizView
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("Quiz")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
                .tag(0)

            userView
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
                .tag(1)
        }
        .accentColor(Color(red: 0.453, green: 0.308, blue: 0.637))
    }

}

struct TabBarView_Previews: PreviewProvider {

    static var previews: some View {
        TabBarView(quizView: Container.quizView(), userView: Container.userView())
    }

}
