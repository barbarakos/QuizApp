import Combine
import UIKit
import SnapKit

class QuestionView: UIView {

    private let margins = 10
    private let questionInsets = 20
    private let buttonTopOffset = 30

    private var cancellables = Set<AnyCancellable>()
    private var answers: [AnswerModel]!
    private var correctAnswerId: Int!
    private var questionLabel: UILabel!
    private var stackView: UIStackView!

    @Published var isCorrectAnswer: Bool?

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setQuestion(question: QuestionModel) {
        answers = question.answers
        correctAnswerId = question.correctAnswerId
        questionLabel.text = question.question
        cancellables.removeAll()
        setAnswerButtons()
    }

    func setAnswerButtons() {
        stackView.subviews.forEach { $0.removeFromSuperview() }

        answers.forEach { answer in
            let answerButton = IdentifiableButton(id: answer.id)
            let title = NSAttributedString(
                string: answer.answer,
                attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .semibold),
                             .foregroundColor: UIColor.white]
            )
            answerButton.titleLabel?.numberOfLines = 0
            answerButton.titleLabel?.lineBreakMode = .byWordWrapping
            answerButton.setAttributedTitle(title, for: .normal)
            answerButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.leading
            answerButton.addConstraint(
                NSLayoutConstraint(
                    item: answerButton,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: answerButton.titleLabel,
                    attribute: .height,
                    multiplier: 1.0,
                    constant: 40))
            answerButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
            answerButton.layer.cornerRadius = 30
            answerButton.backgroundColor = .white.withAlphaComponent(0.3)

            answerButton
                .tap
                .sink { [weak self] _ in
                    guard let self = self else { return }

                    let isCorrect = answer.id == self.correctAnswerId
                    self.colorAnswers(selectedAnswer: answerButton, isCorrect: isCorrect)

                    self.isCorrectAnswer = isCorrect
                    // update progress bar views color and go to next question
                }
                .store(in: &cancellables)

            stackView.addArrangedSubview(answerButton)
        }
    }

    private func colorAnswers(selectedAnswer: IdentifiableButton, isCorrect: Bool) {
        selectedAnswer.backgroundColor = isCorrect ? .correct : .incorrect
        if !isCorrect {
            stackView
                .subviews
                .forEach { button in
                    guard let button = button as? IdentifiableButton, button.id == correctAnswerId else { return }

                    button.backgroundColor = .correct
                }
        }
    }

}

extension QuestionView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        questionLabel = UILabel()
        addSubview(questionLabel)

        stackView = UIStackView()
        addSubview(stackView)
    }

    func styleViews() {
        questionLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0

        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margins)
            $0.leading.trailing.equalToSuperview().inset(questionInsets)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(buttonTopOffset)
            $0.leading.trailing.equalToSuperview().inset(margins)
        }
    }

}
