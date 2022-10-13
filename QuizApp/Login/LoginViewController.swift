import UIKit
import SnapKit

class LoginViewController: UIViewController {

    private var loginViewModel: LoginViewModel!

    var gradientBg: CAGradientLayer!
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var logInButton: UIButton!
    var stackView: UIStackView!

    convenience init(viewModel: LoginViewModel) {
        self.init()
        self.loginViewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    @objc func handleLogIn() {
        guard let password = passwordTextField.text, let username = emailTextField.text else {
            return
        }

        loginViewModel.login(username: username, password: password)
    }

    @objc func textFieldDidChange() {
        let inputFieldsValid = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
        logInButton.isUserInteractionEnabled = inputFieldsValid
        let alpha: CGFloat = inputFieldsValid ? 1 : 0.6
        logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
    }

}

extension LoginViewController: ConstructViewsProtocol {

    func createViews() {
        gradientBg = CAGradientLayer()
        gradientBg.type = .axial
        view.layer.addSublayer(gradientBg)

        titleLabel = UILabel()
        view.addSubview(titleLabel)

        emailTextField = UITextField()
        passwordTextField = UITextField()
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        logInButton = UIButton(type: .system)
        stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, logInButton])

        view.addSubview(stackView)
    }

    func styleViews() {
        gradientBg.colors = [
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
        logInButton.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        gradientBg.frame = view.bounds
        gradientBg.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.height.equalTo(30)
        }

        stackView.snp.makeConstraints {
            $0.bottom.lessThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(70)
            $0.top.lessThanOrEqualTo(titleLabel.snp.bottom).offset(150)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(20)
            $0.height.equalTo(170)
        }
    }

}

extension LoginViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.borderWidth = 0.7
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 0
        let inputFieldsValid = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
        logInButton.isUserInteractionEnabled = inputFieldsValid
        let alpha: CGFloat = inputFieldsValid ? 1 : 0.6
        logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: alpha)
    }

}
