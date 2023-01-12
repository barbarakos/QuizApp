import SwiftUI
import Factory

struct QuizListView: View {

    @ObservedObject private var network: Network
    @ObservedObject private var viewModel: QuizViewModel

    init(network: Network, viewModel: QuizViewModel) {
        self.network = network
        self.viewModel = viewModel
        setSegmentedControlAppearance()
    }

    var body: some View {
        VStack {
            Picker("", selection: $viewModel.segmentationSelection) {
                ForEach(viewModel.categories, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.top, .horizontal], 7)
            .cornerRadius(10)

            if let err = viewModel.quizError {
                ErrorView(title: err.title, description: err.description)
            }

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(CategorySection.allCases, id: \.self) { section in
                        if !viewModel.filteredQuizzes(section).isEmpty {
                            Section(header: Text(section.rawValue).sectionHeaderStyle(section)) {
                                ForEach(viewModel.filteredQuizzes(section), id: \.self) { quiz in
                                    QuizCellView(quiz: quiz)
                                        .onTapGesture {
                                            viewModel.showQuizDetails(quiz: quiz)
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .padding([.top, .horizontal], 10)
        }
        .padding(.top, 5)
        .background(LinearGradient.quizAppGradient)
        .popup(isPresented: $network.isDisconnected)
    }

    private func setSegmentedControlAppearance() {
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
        UISegmentedControl.appearance().backgroundColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 0.5)
        UISegmentedControl.appearance().apportionsSegmentWidthsByContent = true
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }

}

struct QuizListView_Previews: PreviewProvider {

    static var previews: some View {
        QuizListView(network: Container.network(), viewModel: Container.quizViewModel())
    }

}
