import UIKit
import SnapKit

class NoQuizErrorView: UIView {

    private var errorImageView: UIImageView!
    private var titleLabel: UILabel!
    private var errorDescriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    func set(title: String, errorDescripton: String) {
        titleLabel.text = title
        errorDescriptionLabel.text = errorDescripton
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension NoQuizErrorView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        errorImageView = UIImageView()
        addSubview(errorImageView)

        titleLabel = UILabel()
        addSubview(titleLabel)

        errorDescriptionLabel = UILabel()
        addSubview(errorDescriptionLabel)
    }

    func styleViews() {
        errorImageView.image = UIImage(named: "error")
        errorImageView.contentMode = .scaleAspectFit
        errorImageView.layer.masksToBounds = true

        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        errorDescriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        errorDescriptionLabel.numberOfLines = 0
        errorDescriptionLabel.lineBreakMode = .byTruncatingTail
        errorDescriptionLabel.textColor = .white
        errorDescriptionLabel.textAlignment = .center
    }

    func defineLayoutForViews() {
        errorImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(errorImageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        errorDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.trailing.lessThanOrEqualToSuperview()
        }
    }

}
