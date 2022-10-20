import UIKit

class DifficultyStackView: UIStackView {

    enum Constants {

        static let rectangleConstant = 12
        static let cornerRadius = 3
    }

    var type: DifficultyEnum = .easy
    private var difficultyView1: UIView!
    private var difficultyView2: UIView!
    private var difficultyView3: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildViews()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func setDifficulty() {
        switch type {
        case .easy:
            difficultyView1.backgroundColor = .yellow
            difficultyView2.backgroundColor = UIColor(white: 1, alpha: 0.7)
            difficultyView3.backgroundColor = UIColor(white: 1, alpha: 0.7)
        case .normal:
            difficultyView1.backgroundColor = .yellow
            difficultyView2.backgroundColor = .yellow
            difficultyView3.backgroundColor = UIColor(white: 1, alpha: 0.7)
        case .hard:
            difficultyView1.backgroundColor = .yellow
            difficultyView2.backgroundColor = .yellow
            difficultyView3.backgroundColor = .yellow

        }
    }

}

extension DifficultyStackView: ConstructViewsProtocol {

    func createViews() {
        difficultyView1 = UIView()
        self.addArrangedSubview(difficultyView1)

        difficultyView2 = UIView()
        self.addArrangedSubview(difficultyView2)

        difficultyView3 = UIView()
        self.addArrangedSubview(difficultyView3)
    }

    func styleViews() {
        difficultyView1.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        difficultyView2.layer.cornerRadius = CGFloat(Constants.cornerRadius)
        difficultyView3.layer.cornerRadius = CGFloat(Constants.cornerRadius)

        let transform = CGAffineTransformMakeRotation(0.7854)
        difficultyView1.transform = transform
        difficultyView2.transform = transform
        difficultyView3.transform = transform

        axis = .horizontal
        spacing = 5
        distribution = .equalCentering
        alignment = .center
    }

    func defineLayoutForViews() {
        difficultyView1.snp.makeConstraints {
            $0.width.equalTo(Constants.rectangleConstant)
            $0.height.equalTo(Constants.rectangleConstant)
        }

        difficultyView2.snp.makeConstraints {
            $0.width.equalTo(Constants.rectangleConstant)
            $0.height.equalTo(Constants.rectangleConstant)
        }

        difficultyView3.snp.makeConstraints {
            $0.width.equalTo(Constants.rectangleConstant)
            $0.height.equalTo(Constants.rectangleConstant)
        }
    }

}
