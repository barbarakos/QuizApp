import Combine
import UIKit
import SnapKit

class LoginViewController: UIViewController {

    private var cancellables = Set<AnyCancellable>()

    private var loginViewModel: LoginViewModel!
    private var gradientLayer: CAGradientLayer!
    private var titleLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var logInButton: UIButton!
    private var stackView: UIStackView!

    init(viewModel: LoginViewModel) {
        self.loginViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViews()
    }

    private func handleLogIn() {
        guard
            let username = emailTextField.text,
            let password = passwordTextField.text
        else { return }

        loginViewModel.login(username: username, password: password)
    }

    func textFieldDidChange() {
        let inputFieldsValid = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
        logInButton.isUserInteractionEnabled = inputFieldsValid
        let alpha: CGFloat = inputFieldsValid ? 1 : 0.6
        logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        view.layer.addSublayer(gradientLayer)

        titleLabel = UILabel()
        view.addSubview(titleLabel)

        emailTextField = UITextField()
        passwordTextField = UITextField()

        logInButton = UIButton(type: .system)
        stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logInButton])

        view.addSubview(stackView)
    }

    func styleViews() {
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white

        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)]
        )
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(14, 0, 0)
        emailTextField.textColor = UIColor.white
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.returnKeyType = .continue
        emailTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)

        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)]
        )
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(14, 0, 0)
        passwordTextField.textColor = UIColor.white
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.returnKeyType = .done
        passwordTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)

        logInButton.setTitle("Login", for: .normal)
        logInButton.setTitleColor(UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1), for: .normal)
        logInButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        logInButton.layer.cornerRadius = 15
        let inputFieldsValid = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
        logInButton.isUserInteractionEnabled = inputFieldsValid
        let alpha: CGFloat = inputFieldsValid ? 1 : 0.6
        logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)

        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        gradientLayer.frame = UIScreen.main.bounds
        gradientLayer.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.height.equalTo(30)
        }

        stackView.snp.makeConstraints {
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(70)
            $0.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(150)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(170)
        }
    }

}

extension LoginViewController {

    func bindViews() {
        emailTextField
            .textDidChange
            .sink { [weak self] _ in
                self?.textFieldDidChange()
            }
            .store(in: &cancellables)

        passwordTextField
            .textDidChange
            .sink { [weak self] _ in
                self?.textFieldDidChange()
            }
            .store(in: &cancellables)

        emailTextField
            .textDidBeginEditing
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.textFieldDidBeginEditing(self.emailTextField)
            }
            .store(in: &cancellables)

        emailTextField
            .textDidEndEditing
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.textFieldDidEndEditing(self.emailTextField)
            }
            .store(in: &cancellables)

        passwordTextField
            .textDidBeginEditing
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.textFieldDidBeginEditing(self.passwordTextField)
            }
            .store(in: &cancellables)

        passwordTextField
            .textDidEndEditing
            .sink { [weak self] _ in
                guard let self = self else { return }

                self.textFieldDidEndEditing(self.passwordTextField)
            }
            .store(in: &cancellables)

        logInButton
            .tap
            .sink { [weak self] _ in
                self?.handleLogIn()
            }
            .store(in: &cancellables)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.7
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
    }

}
