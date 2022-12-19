import SwiftUI
import Factory

struct QuizListView: View {

    @State private var segmentationSelection: String = "All"
    @ObservedObject private var viewModel: QuizViewModel

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
        setSegmentedControlAppearance()
    }

    var body: some View {
        ZStack {
            LinearGradient
                .quizAppGradient
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Picker("", selection: $segmentationSelection) {
                        let items = ["All"] + CategorySection.allCases.map {$0.rawValue}
                        ForEach(items, id: \.self) { option in
                            Text(option)
                        }
                    }
                    .onChange(of: segmentationSelection) { _ in
                        getQuizzes()
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .cornerRadius(10)

                    let allCategories = CategorySection.allCases.map { $0.rawValue }
                    if allCategories.contains(segmentationSelection) {
                        let section = CategorySection(rawValue: segmentationSelection)!
                        Section(header: Text(section.rawValue)
                            .sectionHeaderStyle(section)) {
                                ForEach(viewModel.quizzes, id: \.self) { quiz in
                                    QuizCellView(quiz: quiz)
                                        .onTapGesture {
                                            viewModel.showQuizDetails(quiz: quiz)
                                        }
                                }
                                .cornerRadius(30)
                            }
                    } else {
                        ForEach(CategorySection.allCases, id: \.self) { section in
                            let filteredQuizzes = viewModel
                                .quizzes
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
                }
                .onAppear {
                    getQuizzes()
                }
                .padding(.horizontal, 10)
            }
        }
    }

    func getQuizzes() {
        let allCategories = CategorySection.allCases.map { $0.rawValue }
        if allCategories.contains(segmentationSelection) {
            viewModel.getQuizzes(for: segmentationSelection.uppercased())
        } else {
            viewModel.getAllQuizzes()
        }
    }

    func setSegmentedControlAppearance() {
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
        QuizListView(viewModel: Container.quizViewModel())
    }

}
