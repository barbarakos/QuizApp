import SwiftUI
import Factory

struct LeaderboardView: View {

    @ObservedObject var viewModel: LeaderboardViewModel

    var body: some View {
        ZStack {
            LinearGradient
                .quizAppGradient
                .ignoresSafeArea()
            VStack {
                Text("Leaderboard")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, -30)

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
                    ForEach(viewModel.leaderboard, id: \.index) { model in
                        VStack {
                            HStack {
                                Text("\(model.index+1)")
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
                                .overlay(.black)
                                .frame(height: 3)
                        }
                    }
                }
                Spacer()
            }
        }
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
