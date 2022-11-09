import UIKit
import SnapKit

class LeaderboardTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: LeaderboardTableViewCell.self)

    private let insetFromSuperview = 20
    private let offset = 7

    private var rankLabel: UILabel!
    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        buildViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(number: Int, leaderboardPlayer: LeaderboardModel) {
        rankLabel.text = "\(number)."
        nameLabel.text = "\(leaderboardPlayer.name)"
        pointsLabel.text = "\(leaderboardPlayer.points)"
    }

}

extension LeaderboardTableViewCell: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        rankLabel = UILabel()
        contentView.addSubview(rankLabel)

        nameLabel = UILabel()
        contentView.addSubview(nameLabel)

        pointsLabel = UILabel()
        contentView.addSubview(pointsLabel)
    }

    func styleViews() {
        backgroundColor = .clear

        rankLabel.textColor = .white
        rankLabel.font = .systemFont(ofSize: 20, weight: UIFont.Weight.heavy)

        nameLabel.textAlignment = .left
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)

        pointsLabel.textAlignment = .right
        pointsLabel.textColor = .white
        pointsLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.heavy)
    }

    func defineLayoutForViews() {
        rankLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(offset)
            $0.leading.equalToSuperview().inset(insetFromSuperview)
        }

        nameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(offset)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(offset)
        }

        pointsLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(offset)
            $0.trailing.equalToSuperview().inset(insetFromSuperview)
        }
    }

}
