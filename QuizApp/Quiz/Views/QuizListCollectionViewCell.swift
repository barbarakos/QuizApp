import Foundation
import UIKit
import Kingfisher
import SnapKit

class QuizListCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuizListCollectionViewCell.self)

    private let margins = 10
    private let trailingConstant = 20

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

        difficultyView.setDifficulty(type: quiz.difficulty)

        let imageUrl = URL(string: quiz.imageUrl)
        imageView.kf.setImage(with: imageUrl, placeholder: UIImage(systemName: "photo"))
    }

}

extension QuizListCollectionViewCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

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
        contentView.backgroundColor = .white.withAlphaComponent(0.3)
        contentView.layer.cornerRadius = 15

        imageView.layer.cornerRadius = 10
        imageView.tintColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1)
        imageView.contentMode = .scaleAspectFill
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
            $0.leading.equalTo(imageView.snp.trailing).offset(margins)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(10)
            $0.leading.equalTo(imageView.snp.trailing).offset(margins)
            $0.trailing.equalToSuperview().inset(trailingConstant)
            $0.bottom.equalToSuperview().inset(margins)
        }

        difficultyView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(margins)
            $0.trailing.equalToSuperview().inset(trailingConstant)
            $0.height.equalTo(20)
            $0.width.equalTo(50)
        }
    }

}
