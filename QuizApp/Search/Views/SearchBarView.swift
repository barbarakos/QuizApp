import UIKit
import SnapKit

class SearchBarView: UIView {

    var textField: UITextField!
    var searchButton: UIButton!

    private let textFieldHeight = 45
    private let margins = 20
    private let space = 10

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SearchBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        textField = UITextField()
        addSubview(textField)

        searchButton = UIButton()
        addSubview(searchButton)
    }

    func styleViews() {
        textField.backgroundColor = .white.withAlphaComponent(0.5)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textField.layer.cornerRadius = 20
        textField.layer.borderColor = UIColor.white.cgColor
        textField.textColor = .white
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 2, 2)

        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        searchButton.addAction( .init {_ in
            self.textField.endEditing(true)
        }, for: .touchUpInside)
    }

    func defineLayoutForViews() {
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(margins)
            $0.height.equalTo(textFieldHeight)
        }

        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(space)
            $0.leading.equalTo(textField.snp.trailing).offset(margins)
            $0.trailing.equalToSuperview().inset(margins)
        }
    }

}
