import SwiftUI

struct QuizResultView: View {

    @ObservedObject var viewModel: QuizResultViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.result)
                .foregroundColor(.white)
                .font(.system(size: 100))
                .bold()
            Spacer()
            HStack {
                Spacer()
                Button("Finish quiz") {
                    viewModel.finishQuiz()
                }
                .frame(width: 300, height: 50)
                .background(.white)
                .cornerRadius(20)
                .font(.system(size: 16))
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding()
                Spacer()
            }
        }
        .background(LinearGradient.quizAppGradient)
    }

}
