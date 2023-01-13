import SwiftUI
import Factory

struct LeaderboardView: View {

    @ObservedObject var viewModel: LeaderboardViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Player")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .padding()
                Spacer()
                Text("Points")
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .padding()

            }

            ScrollView {
                LazyVStack {
                    ForEach(viewModel.leaderboard, id: \.index) { model in
                        HStack {
                            Text("\(model.index + 1)")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .fontWeight(.heavy)
                                .padding(.horizontal)
                            Text(model.name)
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding(.horizontal)
                            Spacer()
                            Text("\(model.points)")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .fontWeight(.heavy)
                                .padding(.horizontal)
                        }
                        Divider()
                            .overlay(.white)
                            .frame(height: 3)
                    }
                }
            }
            Spacer()
        }
        .background(LinearGradient.quizAppGradient)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(alignment: .center) {
                    Button {
                        viewModel.closeLeaderboard()
                    } label: {
                        Image(systemName: "xmark")
                            .tint(.white)
                    }
                }
            }
        }
    }

}

struct LeaderboardView_Previews: PreviewProvider {

    static var previews: some View {
        LeaderboardView(viewModel: Container.leaderboardViewModel(5))
    }

}
