import UIKit
import Combine
import SnapKit

class LeaderboardViewController: UIViewController {

    private let insetFromSuperview = 20
    private let insetToData = 50

    private var cacellables = Set<AnyCancellable>()
    private var leaderboard: [LeaderboardResponseModel] = []
    private var leaderboardViewModel: LeaderboardViewModel!
    private var gradientLayer: CAGradientLayer!
    private var titleLabel: UILabel!
    private var playerLabel: UILabel!
    private var pointsLabel: UILabel!
    private var tableView: UITableView!

    init(viewModel: LeaderboardViewModel) {
        self.leaderboardViewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        bindViewModel()
        configureTableView()
        setNavigationBar()
    }

    private func bindViewModel() {
        leaderboardViewModel
            .$leaderboard
            .sink { [weak self] leaderboard in
                guard let self = self else { return }

                self.leaderboard = leaderboard
                self.tableView.reloadData()
            }
            .store(in: &cacellables)
    }

    @objc private func closeLeaderboard() {
        leaderboardViewModel.closeLeaderboard()
    }

    func configureTableView() {
        tableView.register(
            LeaderboardTableViewCell.self,
            forCellReuseIdentifier: LeaderboardTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension LeaderboardViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        titleLabel = UILabel()

        gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        view.layer.addSublayer(gradientLayer)

        playerLabel = UILabel()
        view.addSubview(playerLabel)

        pointsLabel = UILabel()
        view.addSubview(pointsLabel)

        tableView = UITableView()
        view.addSubview(tableView)
    }

    func styleViews() {
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        titleLabel.text = "Leaderboard"
        titleLabel.font = .systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        titleLabel.textColor = .white

        playerLabel.textAlignment = .left
        playerLabel.text = "Player"
        playerLabel.textColor = .white
        playerLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight.light)

        pointsLabel.textAlignment = .right
        pointsLabel.text = "Points"
        pointsLabel.textColor = .white
        pointsLabel.font = .systemFont(ofSize: 18, weight: UIFont.Weight.light)

        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets.zero
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0, 1]

        playerLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(insetToData)
            $0.leading.equalToSuperview().inset(insetFromSuperview)
        }

        pointsLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(insetToData)
            $0.trailing.equalToSuperview().inset(insetFromSuperview)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(pointsLabel.snp.bottom).offset(7)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setNavigationBar() {
        let closeBarButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeLeaderboard))

        navigationItem.rightBarButtonItem = closeBarButton
        navigationItem.titleView = titleLabel
        navigationItem.hidesBackButton = true
    }

}

extension LeaderboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaderboard.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LeaderboardTableViewCell.reuseIdentifier,
                for: indexPath) as? LeaderboardTableViewCell
        else { fatalError() }

        cell.set(number: indexPath.row + 1, leaderboardPlayer: leaderboard[indexPath.row])
        return cell
    }

}

extension LeaderboardViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
