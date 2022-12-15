import SwiftUI
import Kingfisher

struct QuizCellView: View {

    private var quiz: QuizModel!

    init(quiz: QuizModel) {
        self.quiz = quiz
    }

    var body: some View {
        ZStack {
            Color.white.opacity(0.3).ignoresSafeArea()
            HStack {
                KFImage
                    .url(URL(string: quiz.imageUrl))
                    .placeholder {
                        Image(systemName: "photo")
                            .scaleEffect(5.0)
                    }
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 110, height: 110, alignment: .leading)
                    .scaledToFit()
                    .clipped()
                    .padding(15)

                VStack(alignment: .leading) {
                    HStack {
                        Text(quiz.name)
                            .fontWeight(.bold)
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .padding(.top, 15)
                        Spacer()
                        DifficultyViews(type: quiz.difficulty)
                            .padding(.trailing, 5)
                    }

                    Text(quiz.description)
                        .fontWeight(.regular)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .padding(.trailing, 7)

                    Spacer()
                }
                .padding([.bottom], 15)

                Spacer()
            }
        }
    }

}

struct QuizCellView_Previews: PreviewProvider {

    static var previews: some View {
        QuizCellView(quiz: QuizModel(
            id: 0,
            category: "SPORT",
            description: "description",
            difficulty: DifficultyModel.normal,
            imageUrl: "",
            name: "Quiz Name"))
    }

}
