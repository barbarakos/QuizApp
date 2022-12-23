import SwiftUI

struct AnswersView: View {

    let correctAnswerIndex: Int
    let nextQuestion: (Int, Color) -> Void

    @Binding var numberOfCorrectQuestions: Int
    @Binding var answers: [AnswerModel]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(answers) { answer in
                Button {
                    if answer.index == correctAnswerIndex {
                        correctAnswerSelected(answer)
                    } else {
                        incorrectAnswerSelected(answer)
                    }
                } label: {
                    Text(answer.answer)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 60, maxHeight: .infinity)
                        .background(answers[answer.index].color, in: Capsule())
                }
                .padding(.horizontal)
            }
        }
    }

    private func correctAnswerSelected(_ answer: AnswerModel) {
        numberOfCorrectQuestions += 1
        answers[answer.index].color = Color.correct
        nextQuestion(numberOfCorrectQuestions, Color.correct)
    }

    private func incorrectAnswerSelected(_ answer: AnswerModel) {
        answers[answer.index].color = Color.incorrect
        answers[correctAnswerIndex].color = Color.correct
        nextQuestion(numberOfCorrectQuestions, Color.incorrect)
    }

}
