import SwiftUI
import Factory

struct SearchView: View {

    @ObservedObject var viewModel: QuizViewModel

    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .padding(.horizontal, 10)

            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(CategorySection.allCases, id: \.self) { section in
                        if !viewModel.searchAndFilteredQuizzes(searchText, section).isEmpty {
                            Section(header: Text(section.rawValue).sectionHeaderStyle(section)) {
                                ForEach(viewModel.searchAndFilteredQuizzes(searchText, section), id: \.self) { quiz in
                                    QuizCellView(quiz: quiz)
                                        .onTapGesture {
                                            viewModel.showQuizDetails(quiz: quiz)
                                        }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(.top, 5)
        .background(LinearGradient.quizAppGradient)
    }

}

struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView(viewModel: Container.quizViewModel())
    }

}
