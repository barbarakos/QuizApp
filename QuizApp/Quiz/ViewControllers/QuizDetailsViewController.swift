import Combine
import UIKit
import SnapKit

class QuizDetailsViewController: UIViewController {

    private let insetFromSuperview = 20

    private var cancellables = Set<AnyCancellable>()
    private var quizDetailsViewModel: QuizDetailsViewModel!
    private var gradientLayer: CAGradientLayer!
    private var titleLabel: UILabel!
    private var quizDetailsView: QuizDetailsView!
    private var leaderboardButton: UIButton!

    init(viewModel: QuizDetailsViewModel) {
        self.quizDetailsViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViewModel()
    }

    private func bindViewModel() {
        quizDetailsViewModel
            .$quiz
            .sink { [weak self] quiz in
                self?.quizDetailsView.set(for: quiz)
            }
            .store(in: &cancellables)
    }

    @objc func showLeaderboard() {
        print("Pressed leaderboard!")
    }

}

extension QuizDetailsViewController: ConstructViewsProtocol {

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

        leaderboardButton = UIButton()
        view.addSubview(leaderboardButton)

        quizDetailsView = QuizDetailsView()
        quizDetailsView.set(for: quizDetailsViewModel.quiz)
        view.addSubview(quizDetailsView)
    }

    func styleViews() {
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white

        let title = NSAttributedString(
            string: "Leaderboard",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        leaderboardButton.setAttributedTitle(title, for: .normal)
        leaderboardButton.setTitleColor(.white, for: .normal)
        leaderboardButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        leaderboardButton.isUserInteractionEnabled = true
        leaderboardButton.contentHorizontalAlignment = .right
        leaderboardButton.addTarget(self, action: #selector(showLeaderboard), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-40)
        }

        quizDetailsView.snp.makeConstraints {
            $0.top.equalTo(leaderboardButton.snp.bottom).offset(10)
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(insetFromSuperview)
        }

        leaderboardButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(insetFromSuperview)
        }
    }

}
