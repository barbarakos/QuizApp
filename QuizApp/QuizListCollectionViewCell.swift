import Foundation
import UIKit
import SnapKit
import Kingfisher

class QuizListCollectionViewCell: UICollectionViewCell {

    static let id = "QuizListCollectionViewCell"

    private var quiz: QuizModel!
    private var quizImageView: UIImageView!
    private var quiztitleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var difficultyView1: UIView!
    private var difficultyView2: UIView!
    private var difficultyView3: UIView!
    private var difficultyStackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(for quiz: QuizModel) {
        self.quiz = quiz
        buildViews()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func setDifficulty() {
        difficultyView1.backgroundColor = .yellow
        if quiz.difficulty == "EASY" {
            difficultyView2.backgroundColor = UIColor(white: 1, alpha: 0.7)
            difficultyView3.backgroundColor = UIColor(white: 1, alpha: 0.7)
        } else if quiz.difficulty == "MEDIUM" {
            difficultyView2.backgroundColor = .yellow
            difficultyView3.backgroundColor = UIColor(white: 1, alpha: 0.7)
        } else {
            difficultyView2.backgroundColor = .yellow
            difficultyView3.backgroundColor = .yellow
        }
    }

    override func prepareForReuse() {
        quiztitleLabel.text = ""
        descriptionLabel.text = ""
        difficultyView2.backgroundColor = UIColor(white: 1, alpha: 0.7)
        difficultyView3.backgroundColor = UIColor(white: 1, alpha: 0.7)
        quizImageView.image = nil
    }

}

extension QuizListCollectionViewCell: ConstructViewsProtocol {

    func createViews() {
        quizImageView = UIImageView()
        contentView.addSubview(quizImageView)

        quiztitleLabel = UILabel()
        contentView.addSubview(quiztitleLabel)

        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)

        difficultyView1 = UIView()
        difficultyView1.layer.cornerRadius = 2
        difficultyView2 = UIView()
        difficultyView2.layer.cornerRadius = 2
        difficultyView3 = UIView()
        difficultyView3.layer.cornerRadius = 2
        difficultyStackView = UIStackView(arrangedSubviews: [difficultyView1, difficultyView2, difficultyView3])

        contentView.addSubview(difficultyStackView)
    }

    func styleViews() {
        contentView.layer.cornerRadius = 10

        let url = URL(string: quiz.imageUrl)
        quizImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        quizImageView.tintColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1)

        quiztitleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        quiztitleLabel.text = quiz.name
        quiztitleLabel.textColor = .white

        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        descriptionLabel.text = quiz.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .white

        let transform = CGAffineTransformMakeRotation(0.7854)
        difficultyView1.transform = transform
        difficultyView2.transform = transform
        difficultyView3.transform = transform
        setDifficulty()
        difficultyStackView.axis = .horizontal
        difficultyStackView.spacing = 4
        difficultyStackView.distribution = .equalCentering
        difficultyStackView.alignment = .center
        setDifficulty()
    }

    func defineLayoutForViews() {
        quizImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            $0.width.equalTo(115)
        }

        quiztitleLabel.snp.makeConstraints {
            $0.top.equalTo(quizImageView).offset(8)
            $0.leading.equalTo(quizImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(quiztitleLabel.snp.bottom).inset(5)
            $0.leading.equalTo(quizImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(quizImageView).inset(5)
        }

        difficultyStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }

        difficultyView1.snp.makeConstraints {
            $0.width.equalTo(12)
            $0.height.equalTo(12)
        }

        difficultyView2.snp.makeConstraints {
            $0.width.equalTo(12)
            $0.height.equalTo(12)
        }

        difficultyView3.snp.makeConstraints {
            $0.width.equalTo(12)
            $0.height.equalTo(12)
        }
    }

}
