import Combine
import UIKit
import SnapKit

class QuizSessionViewController: UIViewController {

    private let margins = 10

    private var cancellables = Set<AnyCancellable>()

    private var viewModel: QuizSessionViewModel!
    private var gradientLayer: BackgroundGradient!
    private var scrollView: UIScrollView!
    private var titleLabel: UILabel!
    private var questionNumberLabel: UILabel!
    private var stackView: UIStackView!
    private var progressBarViews: [UIView]!
    private var numOfCorrectQuestions: Int = 0

    private var questionView: QuestionView!

    init(viewModel: QuizSessionViewModel) {
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
        bindViewModel()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        gradientLayer?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }

    func nextQuestion() {
        viewModel.nextQuestion(numOfCorrectQuestions: numOfCorrectQuestions)
    }

    func bindViewModel() {
        viewModel
            .$currentQuestion
            .sink { [weak self] currentQuestion in
                guard let question = currentQuestion else { return }

                self?.setQuestionView(question: question)
            }
            .store(in: &cancellables)
    }

    private func setQuestionView(question: QuestionModel) {
        questionNumberLabel.text = "\(question.index+1)/\(viewModel.quiz.numberOfQuestions)"
        questionView.setQuestion(question: question)
        setProgressViewColor(question: question)
    }

}

extension QuizSessionViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        titleLabel = UILabel()

        gradientLayer = BackgroundGradient()
        view.layer.addSublayer(gradientLayer)

        scrollView = UIScrollView()
        view.addSubview(scrollView)

        questionNumberLabel = UILabel()
        scrollView.addSubview(questionNumberLabel)

        stackView = UIStackView()
        scrollView.addSubview(stackView)

        setProgressStackView()

        questionView = QuestionView()
        scrollView.addSubview(questionView)
    }

    func styleViews() {
        navigationItem.titleView = titleLabel

        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white

        questionNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        questionNumberLabel.textColor = .white

        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        questionNumberLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margins)
            $0.top.equalToSuperview().offset(margins)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(questionNumberLabel.snp.bottom).offset(margins)
            $0.leading.trailing.equalToSuperview().inset(margins)
            $0.height.equalTo(5)
        }

        questionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(margins)
            $0.leading.trailing.bottom.equalToSuperview().inset(margins)
            $0.centerX.equalToSuperview()
        }
    }

}

// MARK: ProgressBar functions
extension QuizSessionViewController {

    func bindViews() {
        questionView
            .$isCorrectAnswer
            .compactMap { $0 }
            .sink { [weak self] isCorrect in
                guard let self = self else { return }

                self.colorProgressViews(isCorrect: isCorrect)
                if isCorrect {
                    self.numOfCorrectQuestions += 1
                }
                self.nextQuestion()
            }
            .store(in: &cancellables)
    }

    private func colorProgressViews(isCorrect: Bool) {
        let progressView = progressBarViews[viewModel.currentQuestion.index]
        progressView.backgroundColor = isCorrect ? .correct : .incorrect
    }

    private func setProgressViewColor(question: QuestionModel) {
        progressBarViews[question.index].backgroundColor = .white
    }

    private func setProgressStackView() {
        progressBarViews = []

        for _ in 1...viewModel.quiz.numberOfQuestions {
            let view = UIView()
            view.backgroundColor = .white.withAlphaComponent(0.3)
            view.layer.cornerRadius = 3
            progressBarViews.append(view)
            stackView.addArrangedSubview(view)
        }
    }

}
