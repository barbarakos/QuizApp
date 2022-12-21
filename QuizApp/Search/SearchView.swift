import SwiftUI
import Factory

struct SearchView: View {

    @ObservedObject var viewModel: QuizViewModel

    @State private var searchText = ""

    var body: some View {
        ScrollView {
            SearchBar(searchText: $searchText)
            VStack(alignment: .leading) {
                ForEach(CategorySection.allCases, id: \.self) { section in
                    let filteredQuizzes = searchResults
                        .filter { $0.category == section.rawValue.uppercased() }
                    if !filteredQuizzes.isEmpty {
                        Section(header: Text(section.rawValue)
                            .sectionHeaderStyle(section)) {
                                ForEach(filteredQuizzes, id: \.self) { quiz in
                                    QuizCellView(quiz: quiz)
                                        .onTapGesture {
                                            viewModel.showQuizDetails(quiz: quiz)
                                        }
                                }
                                .cornerRadius(30)
                            }
                    }
                }
            }
            .onAppear {
                viewModel.getAllQuizzes()
            }
        }
        .padding(.horizontal, 10)
        .background(LinearGradient.quizAppGradient)
    }

    var searchResults: [QuizModel] {
        if searchText.isEmpty {
            return viewModel.quizzes
        } else {
            return viewModel.quizzes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }

}

struct SearchView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView(viewModel: Container.quizViewModel())
    }

}
