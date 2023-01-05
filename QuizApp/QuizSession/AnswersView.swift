import SwiftUI

struct AnswersView: View {

    let nextQuestion: (Int) -> Void

    var answers: [AnswerModel]

    var body: some View {
        VStack(spacing: 10) {
            ForEach(answers) { answer in
                Button {
                    nextQuestion(answer.index)
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
