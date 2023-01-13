import SwiftUI
import Factory

struct LoginView: View {

    @ObservedObject var viewModel: LoginViewModel

    @FocusState private var emailIsFocused: Bool
    @FocusState private var passwordIsFocused: Bool

    var body: some View {
        ZStack {
            LinearGradient
                .quizAppGradient
                .ignoresSafeArea()
            ScrollView(.vertical) {
                VStack {
                    Text("Pop Quiz")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                        .foregroundColor(.white)

                    TextField("Email", text: $viewModel.username)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .focused($emailIsFocused)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(15)
                        .onChange(of: viewModel.username) { _ in
                            viewModel.loginFieldsValid = !viewModel.password.isEmpty && !viewModel.username.isEmpty
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth: emailIsFocused ? 1 : 0)
                        )
                        .padding(.top, 60)

                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .focused($passwordIsFocused)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(15)
                        .onChange(of: viewModel.password) { _ in
                            viewModel.loginFieldsValid = !viewModel.password.isEmpty && !viewModel.username.isEmpty
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.white, lineWidth: passwordIsFocused ? 1 : 0)
                        )

                    Button("Login") {
                        viewModel.login()
                    }
                    .frame(width: 300, height: 50)
                    .background(viewModel.loginFieldsValid ? .white.opacity(1) : .white.opacity(0.6))
                    .cornerRadius(15)
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.453, green: 0.308, blue: 0.637))
                    .disabled(!viewModel.loginFieldsValid)

                    Spacer()
                }
                .padding(.bottom, 60)
            }
        }
        .errorAlert(error: $viewModel.err)
    }

}

struct LoginView_Previews: PreviewProvider {

    static var previews: some View {
        LoginView(viewModel: Container.loginViewModel())
    }

}
