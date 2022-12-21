import SwiftUI
import Factory

struct LoginView: View {

    @State private var username = ""
    @State private var password = ""

    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool

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

                    TextField("Email", text: $username)
                    .padding()
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .focused($emailIsFocused)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.white, lineWidth: emailIsFocused ? 1 : 0)
                    )
                    .padding(.top, 60)

                    SecureField("Password", text: $password)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .focused($passwordIsFocused)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth: passwordIsFocused ? 1 : 0)
                        )

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
