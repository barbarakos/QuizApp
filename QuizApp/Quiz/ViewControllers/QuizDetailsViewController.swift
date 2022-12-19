import Combine
import UIKit
import SnapKit

class QuizDetailsViewController: UIViewController {

    private let insetFromSuperview = 20
    private let topOffset = 10

    private var cancellables = Set<AnyCancellable>()

    private var quizDetailsViewModel: QuizDetailsViewModel!
    private var titleLabel: UILabel!
    private var gradientLayer: BackgroundGradient!
    private var quizDetailsView: QuizDetailsView!
    private var leaderboardButton: UIButton!
    private var scrollView: UIScrollView!
    private var contentView: UIView!

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
        bindViews()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        gradientLayer?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    func showLeaderboard() {
        quizDetailsViewModel.showLeaderboard()
    }

    func startQuiz() {
        quizDetailsViewModel.startQuiz()
    }

    private func bindViewModel() {
        quizDetailsViewModel
            .$quiz
            .sink { [weak self] quiz in
                self?.quizDetailsView.set(for: quiz)
            }
            .store(in: &cancellables)
    }

    private func bindViews() {
        quizDetailsView
            .startButtonTapped
            .sink { [weak self] _ in
                self?.startQuiz()
            }
            .store(in: &cancellables)

        leaderboardButton
            .tap
            .sink { [weak self] _ in
                self?.showLeaderboard()
            }
            .store(in: &cancellables)
    }

}

extension QuizDetailsViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        gradientLayer = BackgroundGradient()
        view.layer.addSublayer(gradientLayer)

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        titleLabel = UILabel()

        leaderboardButton = UIButton()
        scrollView.addSubview(leaderboardButton)

        quizDetailsView = QuizDetailsView()
        scrollView.addSubview(quizDetailsView)
    }

    func styleViews() {
        navigationItem.titleView = titleLabel

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
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds

        leaderboardButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(insetFromSuperview)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(insetFromSuperview)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }

        quizDetailsView.snp.makeConstraints {
            $0.top.equalTo(leaderboardButton.snp.bottom).offset(topOffset)
            $0.centerX.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview().inset(insetFromSuperview)
        }
    }

}
