import UIKit
import SnapKit

class SectionHeaderReusableView: UICollectionReusableView {

    static var reuseIdentifier = String(describing: SectionHeaderReusableView.self)

    private var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(title: String, color: UIColor) {
        self.titleLabel.text = title
        self.titleLabel.textColor = color
    }

}

extension SectionHeaderReusableView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)
    }

    func styleViews() {
        titleLabel.font = UIFont.systemFont(
            ofSize: 25,
            weight: .bold)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

}
