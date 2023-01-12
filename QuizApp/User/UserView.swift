import SwiftUI
import Factory

struct UserView: View {

    @ObservedObject var network: Network
    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("USERNAME")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .padding(.leading, 20)

            Text(viewModel.username)
                .foregroundColor(.white)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding([.leading, .bottom], 20)

            Text("NAME")
                .foregroundColor(.white)
                .font(.system(size: 14))
                .padding(.leading, 20)

            TextField(viewModel.name, text: $viewModel.name)
                .foregroundColor(.white)
                .font(.system(size: 25))
                .fontWeight(.bold)
                .padding(.leading, 20)
                .onSubmit {
                    viewModel.changeName()
                }
            Spacer()
            HStack {
                Spacer()
                Button("Logout") {
                    viewModel.logout()
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
        .padding(.top, 10)
        .background(LinearGradient.quizAppGradient)
        .popup(isPresented: $network.isDisconnected)
    }

}

struct UserView_Previews: PreviewProvider {

    static var previews: some View {
        UserView(network: Container.network(), viewModel: Container.userViewModel())
    }

}
