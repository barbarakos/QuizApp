import UIKit
import SnapKit

class QuizErrorView: UIView {

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    func set(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension QuizErrorView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        imageView = UIImageView()
        addSubview(imageView)

        titleLabel = UILabel()
        addSubview(titleLabel)

        descriptionLabel = UILabel()
        addSubview(descriptionLabel)
    }

    func styleViews() {
        imageView.image = UIImage(named: "error")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true

        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.lessThanOrEqualToSuperview()
        }
    }

}
