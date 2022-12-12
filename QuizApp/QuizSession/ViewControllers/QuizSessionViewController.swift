import Combine
import UIKit
import SnapKit

class QuizSessionViewController: UIViewController {

    private let titleInset = 40
    private let margins = 20
    private let questionInsets = 10

    private var cancellables = Set<AnyCancellable>()

    private var viewModel: QuizSessionViewModel!
    private var gradientLayer: CAGradientLayer!
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

    func nextQuestion() {
        if viewModel.currentQuestion.index+1 < viewModel.questions.count {

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.viewModel.nextQuestion()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                guard let self = self else { return }

                self.viewModel.endQuiz(numberOfCorrectQuestions: self.numOfCorrectQuestions)
                self.viewModel.goToQuizResult(numberOfCorrectQuestions: self.numOfCorrectQuestions)
            }
        }
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
        gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        view.layer.addSublayer(gradientLayer)

        titleLabel = UILabel()
        view.addSubview(titleLabel)

        questionNumberLabel = UILabel()
        view.addSubview(questionNumberLabel)

        stackView = UIStackView()
        view.addSubview(stackView)

        setProgressStackView()

        questionView = QuestionView()
        view.addSubview(questionView)
    }

    func styleViews() {
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

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
        gradientLayer.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-titleInset)
        }

        questionNumberLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(margins)
            $0.top.equalTo(titleLabel.snp.bottom).offset(margins)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(questionNumberLabel.snp.bottom).offset(margins)
            $0.leading.trailing.equalToSuperview().inset(margins)
            $0.height.equalTo(5)
        }

        questionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(50)
            $0.leading.trailing.bottom.equalToSuperview().inset(questionInsets)
        }
    }

}

// MARK: ProgressBar functions
extension QuizSessionViewController {

    func bindViews() {
        questionView
            .$isCorrectAnswer
            .sink {  [weak self] isCorrect in
                guard let self = self, let isCorrect = isCorrect else { return }

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
