import Combine
import UIKit
import SnapKit

class QuizResultViewController: UIViewController {

    private let viewModel: QuizResultViewModel
    private let heightAndMargins = 50

    private var cancellables = Set<AnyCancellable>()

    private var gradientLayer: BackgroundGradient!
    private var resultLabel: UILabel!
    private var finishQuizButton: UIButton!

    init(viewModel: QuizResultViewModel) {
        self.viewModel = viewModel

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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let gradient = gradientLayer else { return }

        gradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    private func bindViews() {
        finishQuizButton
            .tap
            .sink { [weak self] _ in
                self?.viewModel.finishQuiz()
            }
            .store(in: &cancellables)
    }

}

extension QuizResultViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        gradientLayer = BackgroundGradient()
        view.layer.addSublayer(gradientLayer)

        resultLabel = UILabel()
        view.addSubview(resultLabel)

        finishQuizButton = UIButton(type: .system)
        view.addSubview(finishQuizButton)
    }

    func styleViews() {
        gradientLayer.setBackground()

        resultLabel.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        resultLabel.text = "\(viewModel.numberOfCorrectQuestions)/\(viewModel.numberOfQuestions)"
        resultLabel.textColor = .white

        finishQuizButton.setTitle("Finish Quiz", for: .normal)
        finishQuizButton.setTitleColor(UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1), for: .normal)
        finishQuizButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        finishQuizButton.layer.cornerRadius = 25
        finishQuizButton.backgroundColor = .white
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds

        resultLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-heightAndMargins)
        }

        finishQuizButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(heightAndMargins)
            $0.height.equalTo(heightAndMargins)
        }
    }

}
