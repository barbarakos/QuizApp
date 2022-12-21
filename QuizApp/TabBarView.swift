import SwiftUI
import Factory

struct TabBarView: View {

    @State private var selection = 0

    private var quizListView: QuizListView!
    private var searchView: SearchView!
    private var userView: UserView!

    init(quizListView: QuizListView, searchView: SearchView, userView: UserView) {
        self.quizListView = quizListView
        self.searchView = searchView
        self.userView = userView
    }

    var body: some View {
        TabView(selection: $selection) {
            quizListView
                .tabItem {
                    Image(systemName: "stopwatch")
                    Text("Quiz")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
                .tag(0)

            searchView
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
                .tag(1)

            userView
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.white, for: .tabBar)
                .tag(2)
        }
        .accentColor(Color(red: 0.453, green: 0.308, blue: 0.637))
    }

}
