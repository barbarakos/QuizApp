import SwiftUI
import Factory

struct UserView: View {

    @ObservedObject var viewModel: UserViewModel

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient:
                                Gradient(colors:
                                            [Color(red: 0.453, green: 0.308, blue: 0.637),
                                             Color(red: 0.154, green: 0.185, blue: 0.463)]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()

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
                .padding(.top, 30)
            }
            .navigationBarHidden(true)
        }
    }

}

struct UserView_Previews: PreviewProvider {

    static var previews: some View {
        UserView(viewModel: Container.userViewModel())
    }

}
