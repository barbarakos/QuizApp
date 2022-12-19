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
                        numberOfCorrectQuestions += 1
                        answers[answer.index].color = .green
                        nextQuestion(numberOfCorrectQuestions, .green)
                    } else {
                        answers[answer.index].color = .red
                        answers[correctAnswerIndex].color = .green
                        nextQuestion(numberOfCorrectQuestions, .red)
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

}
