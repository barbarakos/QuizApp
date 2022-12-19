import SwiftUI
import Kingfisher

struct QuizInfoView: View {

    let quiz: QuizModel!

    var body: some View {
        ZStack {
            Color.white
                .opacity(0.3)
                .ignoresSafeArea()
                .cornerRadius(20)
            VStack(alignment: .center, spacing: 20) {
                Text(quiz.name)
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                Text(quiz.description)
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 50)
                KFImage
                    .url(URL(string: quiz.imageUrl))
                    .placeholder {
                        Image(systemName: "photo")
                            .scaleEffect(5.0)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 280, height: 300)
                    .cornerRadius(20)
                    .clipped()

                Button("Start Quiz") {
                    print("Tapped start button!")
                }
                .frame(width: 300, height: 50)
                .background(.white)
                .cornerRadius(15)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .padding(.bottom, 15)
                .foregroundColor(Color(red: 0.453, green: 0.308, blue: 0.637))

            }
            .padding(.horizontal, 15)
        }
    }

}

struct QuizInfoView_Previews: PreviewProvider {

    static var previews: some View {
        QuizInfoView(quiz: QuizModel(
            id: 0,
            category: "SPORT",
            description: "Description",
            difficulty: DifficultyModel.normal,
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/1/1d/Football_Pallo_valmiina-cropped.jpg",
            name: "Football",
        numberOfQuestions: 5))
    }

}
