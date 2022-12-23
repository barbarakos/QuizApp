import SwiftUI
import Factory

struct QuizSessionView: View {

    @ObservedObject var viewModel: QuizSessionViewModel

    @State private var numberOfCorrectQuestions = 0
    @State private var progressColors: [Color]

    init(viewModel: QuizSessionViewModel) {
        self.viewModel = viewModel
        progressColors = [Color](repeating: Color.white.opacity(0.3), count: viewModel.quiz.numberOfQuestions)
    }

    var body: some View {
        ScrollView {
            VStack {
                ProgressView(
                    progressColors: $progressColors,
                    numberOfQuestions: viewModel.quiz.numberOfQuestions)

                VStack(alignment: .leading) {
                    if viewModel.currentQuestion != nil {
                        Text(viewModel.questionNumberLabel)
                            .padding(.leading)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(viewModel.currentQuestion.question)
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(.white)
                            .padding()

                        let correctAnswerIndex = getAnswerIndex(
                            id: viewModel.currentQuestion.correctAnswerId,
                            answers: viewModel.currentQuestion.answers)

                        AnswersView(
                            correctAnswerIndex: correctAnswerIndex,
                            nextQuestion: { nextQuestion($0, $1) },
                            numberOfCorrectQuestions: $numberOfCorrectQuestions,
                            answers: $viewModel.currentQuestion.answers)
                    }
                }
            }
            .padding(.top)
        }
        .background(LinearGradient.quizAppGradient)
    }

    private func nextQuestion(_ numOfCorrectQuestions: Int, _ colorProgress: Color) {
        progressColors[viewModel.currentQuestion.index] = colorProgress
        viewModel.nextQuestion(numOfCorrectQuestions: numOfCorrectQuestions)
    }

    private func getAnswerIndex(id: Int, answers: [AnswerModel]) -> Int {
        return answers.indices.filter { answers[$0].id == id }.first!
    }

}

struct QuizSessionView_Previews: PreviewProvider {

    static var previews: some View {
        QuizSessionView(
            viewModel: Container.quizSessionViewModel(
                QuizModel(
                    id: 0,
                    category: "SPORT",
                    description: "Description of the selected quiz.",
                    difficulty: DifficultyModel.normal,
                    imageUrl: "",
                    name: "Football",
                    numberOfQuestions: 5)))
    }

}
