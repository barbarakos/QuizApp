//
//  LoginViewController.swift
//  QuizApp
//
//  Created by Barbara Kos on 04.10.2022..
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    var gradientBg: CAGradientLayer!
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var logInButton: UIButton!
    var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

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
        logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        logInButton.isUserInteractionEnabled = false
        logInButton.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        gradientBg.frame = view.bounds
        gradientBg.locations = [0, 1]

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),

            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            stackView.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 150),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }

    @objc func handleLogIn() {
    }

    @objc func textFieldDidChange() {
        if let text1 = emailTextField.text, let text2 = passwordTextField.text, !text1.isEmpty, !text2.isEmpty {
            logInButton.isUserInteractionEnabled = true
            logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            logInButton.isUserInteractionEnabled = false
            logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
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
        if let text1 = emailTextField.text, let text2 = passwordTextField.text, !text1.isEmpty, !text2.isEmpty {
            logInButton.isUserInteractionEnabled = true
            logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            logInButton.isUserInteractionEnabled = false
            logInButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        }

    }

}
