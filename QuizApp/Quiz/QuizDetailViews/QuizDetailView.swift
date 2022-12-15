import SwiftUI
import Factory

struct QuizDetailView: View {

    @ObservedObject var viewModel: QuizDetailsViewModel

    var body: some View {
            ZStack {
                LinearGradient
                    .quizAppGradient
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Text("Pop Quiz")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, -30)

                        HStack {
                            Spacer()
                            Button(action: { viewModel.showLeaderboard() }) {
                                Text("Leaderboard")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .underline(color: .white)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 40)
                            }
                        }
                        .padding(.top, 30)

                        QuizInfoView(quiz: viewModel.quiz)
                            .padding(.horizontal, 40)
                    }
                }
            }
    }

}

struct QuizDetailView_Previews: PreviewProvider {

    static var previews: some View {
        QuizDetailView(viewModel: Container.quizDetailsViewModel(QuizModel(id: 0,
                                                                category: "SPORT",
                                                                description: "Description of the selected quiz.",
                                                                difficulty: DifficultyModel.normal,
                                                                imageUrl: "",
                                                                name: "Football")))
    }

}
