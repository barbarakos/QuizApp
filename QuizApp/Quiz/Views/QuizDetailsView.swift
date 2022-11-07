import Combine
import UIKit
import SnapKit

class QuizDetailsView: UIView {

    private let imageHeight = 300
    private let startButtonHeight = 45
    private let insetFromSuperview = 30

    private var cancellables = Set<AnyCancellable>()
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var startButton: UIButton!
    private var stackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(for quiz: QuizModel) {
        titleLabel.text = quiz.name
        descriptionLabel.text = quiz.description
        let imageUrl = URL(string: quiz.imageUrl)
        imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "photo"))
    }

    @objc func startQuiz() {
        print("Start button pressed!")
    }

}

extension QuizDetailsView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        imageView = UIImageView()

        titleLabel = UILabel()

        descriptionLabel = UILabel()

        startButton = UIButton(type: .system)

        stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, imageView, startButton])
        addSubview(stackView)
    }

    func styleViews() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 15

        imageView.layer.cornerRadius = 10
        imageView.tintColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center

        startButton.setTitle("Start Quiz", for: .normal)
        startButton.setTitleColor(UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1), for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        startButton.layer.cornerRadius = 15
        startButton.isUserInteractionEnabled = true
        startButton.backgroundColor = .white
        startButton
            .tap
            .sink { _ in
                self.startQuiz()
            }
            .store(in: &cancellables)

        stackView.axis = .vertical
        stackView.spacing = 20
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageHeight)
        }

        startButton.snp.makeConstraints {
            $0.height.equalTo(startButtonHeight)
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insetFromSuperview)
        }
    }

}
