import Foundation
import UIKit
import Combine
import SnapKit

class UserViewController: UIViewController {

    enum Constants {

        static let logoutConstant = 40
        static let margins = 20
        static let height = 30

    }

    var gradientBg: CAGradientLayer!
    var usernameTitleLabel: UILabel!
    var usernameLabel: UILabel!
    var nameTitleLabel: UILabel!
    var nameTextField: UITextField!
    var logOutButton: UIButton!

    private var cancellables = Set<AnyCancellable>()
    private var userViewModel: UserViewModel!

    init(viewModel: UserViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
        userViewModel.getUser()
    }

    @objc func handleLogOut() {
        userViewModel.logout()
    }

    func changeName() {
        guard let name = nameTextField.text else { return }

        userViewModel.changeName(name: name)
    }

    func bindViewModel() {
        userViewModel
            .$username
            .sink { [weak self] username in
                self?.usernameLabel.text = username
            }
            .store(in: &cancellables)

        userViewModel
            .$name
            .sink { [weak self] name in
                self?.nameTextField.text = name
            }
            .store(in: &cancellables)
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        gradientBg = CAGradientLayer()
        gradientBg.type = .axial
        view.layer.addSublayer(gradientBg)

        usernameTitleLabel = UILabel()
        view.addSubview(usernameTitleLabel)

        usernameLabel = UILabel()
        view.addSubview(usernameLabel)

        nameTitleLabel = UILabel()
        view.addSubview(nameTitleLabel)

        nameTextField = UITextField()
        view.addSubview(nameTextField)

        logOutButton = UIButton(type: .system)
        view.addSubview(logOutButton)
    }

    func styleViews() {
        gradientBg.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        usernameTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        usernameTitleLabel.text = "USERNAME"
        usernameTitleLabel.textColor = .white

        usernameLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        usernameLabel.textColor = .white

        nameTitleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        nameTitleLabel.text = "NAME"
        nameTitleLabel.textColor = .white

        nameTextField.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        nameTextField.textColor = .white
        nameTextField.delegate = self
        nameTextField.isUserInteractionEnabled = true

        logOutButton.setTitle("Log out", for: .normal)
        logOutButton.setTitleColor(UIColor.red, for: .normal)
        logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        logOutButton.layer.cornerRadius = 15
        logOutButton.backgroundColor = UIColor.white
        logOutButton.addTarget(self, action: #selector(handleLogOut), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        gradientBg.frame = view.bounds
        gradientBg.locations = [0, 1]

        usernameTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.height.equalTo(Constants.height)
        }

        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.top.equalTo(usernameTitleLabel.snp.bottom).offset(5)
            $0.height.equalTo(Constants.height)
        }

        nameTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(Constants.margins)
            $0.height.equalTo(Constants.height)
        }

        nameTextField.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.top.equalTo(nameTitleLabel.snp.bottom).offset(5)
            $0.height.equalTo(Constants.height)
        }

        logOutButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.logoutConstant)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.logoutConstant)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Constants.logoutConstant)
            $0.height.equalTo(Constants.logoutConstant)
        }
    }

}

extension UserViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        changeName()
        return true
    }

}
