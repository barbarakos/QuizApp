import SwiftUI
import Factory

struct QuizView: View {

    private var viewModel: QuizViewModel!

    init(viewModel: QuizViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text("Quiz")
    }

}

struct QuizView_Previews: PreviewProvider {

    static var previews: some View {
        QuizView(viewModel: Container.quizViewModel())
    }

}
