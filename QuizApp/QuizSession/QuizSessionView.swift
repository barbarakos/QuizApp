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
                    if let currQuestion = viewModel.currentQuestion {
                        Text(viewModel.questionNumberLabel)
                            .padding(.leading)
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text(currQuestion.question)
                            .font(.system(size: 24))
                            .bold()
                            .foregroundColor(.white)
                            .padding()

                        AnswersView(
                            nextQuestion: { nextQuestion($0) },
                            answers: currQuestion.answers)
                    }
                }
            }
            .padding(.top)
        }
        .background(LinearGradient.quizAppGradient)
    }

    private func nextQuestion(_ index: Int) {
        guard var currQuestion = viewModel.currentQuestion else { return }

        let correctAnswerIndex = getAnswerIndex(
            id: currQuestion.correctAnswerId,
            answers: currQuestion.answers)

        if index == correctAnswerIndex {
            viewModel.currentQuestion?.answers[index].color = Color.correct
            progressColors[currQuestion.index] = Color.correct
            numberOfCorrectQuestions += 1
        } else {
            viewModel.currentQuestion?.answers[correctAnswerIndex].color = Color.correct
            viewModel.currentQuestion?.answers[index].color = Color.incorrect
            progressColors[currQuestion.index] = Color.incorrect
        }

        viewModel.nextQuestion(numOfCorrectQuestions: numberOfCorrectQuestions)
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
