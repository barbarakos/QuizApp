import UIKit
import SnapKit

class SectionHeaderReusableView: UICollectionReusableView {

    static var reuseIdentifier = String(describing: SectionHeaderReusableView.self)

    var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(10)
            $0.trailing.lessThanOrEqualTo(safeAreaLayoutGuide).inset(10)
            $0.top.bottom.equalToSuperview().inset(10)
        }
    }

}
