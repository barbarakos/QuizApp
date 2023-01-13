import SwiftUI
import Factory

struct QuizDetailView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    viewModel.showLeaderboard()
                } label: {
                    Text("Leaderboard")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .underline(color: .white)
                        .foregroundColor(.white)
                        .padding(.trailing, 40)
                }
            }
            .padding(.top, 30)

            ScrollView {
                QuizInfoView(quiz: viewModel.quiz) {
                    viewModel.startQuiz()
                }
                .padding(.horizontal, 30)
            }
        }
        .padding(.top, 5)
        .background(LinearGradient.quizAppGradient)
    }

}
