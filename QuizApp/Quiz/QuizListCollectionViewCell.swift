import Foundation
import UIKit
import Kingfisher
import SnapKit

class QuizListCollectionViewCell: UICollectionViewCell {

    enum Constants {

        static let margins = 10
        static let trailingConstant = 20
    }

    static let reuseIdentifier = String(describing: QuizListCollectionViewCell.self)

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var difficultyView: DifficultyStackView!

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

        difficultyView.type = DifficultyEnum(rawValue: quiz.difficulty)!
        difficultyView.setDifficulty()

        let imageUrl = URL(string: quiz.imageUrl)
        imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "photo"))
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

}

extension QuizListCollectionViewCell: ConstructViewsProtocol {

    func createViews() {
        imageView = UIImageView()
        contentView.addSubview(imageView)

        titleLabel = UILabel()
        contentView.addSubview(titleLabel)

        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)

        difficultyView = DifficultyStackView()
        contentView.addSubview(difficultyView)
    }

    func styleViews() {
        contentView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        contentView.layer.cornerRadius = 15

        imageView.layer.cornerRadius = 10
        imageView.tintColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true

        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        titleLabel.textColor = .white

        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .white
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(115)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.margins)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(10)
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.margins)
            $0.trailing.equalToSuperview().inset(Constants.trailingConstant)
            $0.bottom.equalToSuperview().inset(Constants.margins)
        }

        difficultyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.margins)
            $0.trailing.equalToSuperview().inset(Constants.trailingConstant)
            $0.height.equalTo(20)
            $0.width.equalTo(50)
        }
    }

}
