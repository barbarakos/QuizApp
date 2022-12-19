import SwiftUI
import Factory

struct LoginView: View {

    @State private var username = ""
    @State private var password = ""
    @State private var usernameFieldBorder = 0
    @State private var passwordFieldBorder = 0

    var viewModel: LoginViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient:
                            Gradient(colors:
                                        [Color(red: 0.453, green: 0.308, blue: 0.637),
                                         Color(red: 0.154, green: 0.185, blue: 0.463)]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack {
                    Text("Pop Quiz")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.white)

                    TextField(
                        "Email",
                        text: $username,
                        onEditingChanged: { (isStart) in
                            if isStart {
                                passwordFieldBorder = 0
                                usernameFieldBorder = 1
                            } else {
                                usernameFieldBorder = 0
                            }
                        })
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: CGFloat(usernameFieldBorder))
                    )
                    .padding(.top, 60)

                    SecureField("Password", text: $password)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth: CGFloat(passwordFieldBorder))
                        )
                        .onTapGesture {
                            usernameFieldBorder = 0
                            passwordFieldBorder = 1
                        }

                    Button("Login") {
                        viewModel.login(username: username, password: password)
                    }
                    .frame(width: 300, height: 50)
                    .background(buttonColor)
                    .cornerRadius(15)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.453, green: 0.308, blue: 0.637))
                    .disabled(!loginFieldsValid)

                    Spacer()
                }
                .padding(.bottom, 60)
            }
        }
    }

    var loginFieldsValid: Bool {
        return !password.isEmpty && !username.isEmpty
    }

    var buttonColor: Color {
        return loginFieldsValid ? .white.opacity(1) : .white.opacity(0.6)
    }

}

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView(viewModel: Container.loginViewModel())
    }

}
