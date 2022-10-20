import UIKit
import SnapKit

class QuizViewController: UIViewController {

    enum Constants {

        static let topOffset = 20
        static let margins = 10
        static let height = 30

    }

    enum CategorySection {

        case main
        case greography
        case movies
        case music
        case sport

    }

    typealias DataSource = UICollectionViewDiffableDataSource<CategorySection, QuizModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategorySection, QuizModel>

    var gradientBg: CAGradientLayer!
    var titleLabel: UILabel!
    var segmented: UISegmentedControl!
    var quizListCollectionView: UICollectionView!

    private lazy var dataSource = makeDataSource()
    private var quizViewModel: QuizViewModel!

    init(viewModel: QuizViewModel) {
        self.quizViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        configureCollectionView()
        didSelectCategory()
        applySnapshot(animatingDifferences: false)
    }

    func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(quizViewModel.quizzes)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: quizListCollectionView,
            cellProvider: { (collectionView, indexPath, quiz) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: QuizListCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? QuizListCollectionViewCell
                cell?.set(for: quiz)
                return cell
            })
        return dataSource
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    @MainActor
    @objc func didSelectCategory() {
        guard let category = segmented.titleForSegment(at: segmented.selectedSegmentIndex) else { return }

        quizViewModel.getQuizzes(for: category.uppercased(), completion: {
            DispatchQueue.main.async { [weak self] in
                self?.applySnapshot()
            }
        })
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func createViews() {
        gradientBg = CAGradientLayer()
        gradientBg.type = .axial
        view.layer.addSublayer(gradientBg)

        titleLabel = UILabel()
        view.addSubview(titleLabel)

        segmented = UISegmentedControl(items: ["Geography", "Movies", "Music", "Sport"])
        view.addSubview(segmented)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        quizListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(quizListCollectionView)
    }

    func styleViews() {
        gradientBg.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white

        segmented.addTarget(self, action: #selector(didSelectCategory), for: .valueChanged)
        segmented.layer.cornerRadius = 10
        segmented.selectedSegmentIndex = 0
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmented.setTitleTextAttributes(titleAttributes, for: .normal)
        segmented.setTitleTextAttributes(titleAttributes, for: .selected)
        segmented.apportionsSegmentWidthsByContent = true
        segmented.selectedSegmentTintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
        segmented.backgroundColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 0.5)

        quizListCollectionView.backgroundColor = .clear
        quizListCollectionView.isScrollEnabled = true
        quizListCollectionView.layer.cornerRadius = 7
    }

    func defineLayoutForViews() {
        gradientBg.frame = view.bounds
        gradientBg.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-Constants.height)
            $0.height.equalTo(Constants.height)
        }

        segmented.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.topOffset)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.margins)
            $0.height.equalTo(Constants.height)
        }

        quizListCollectionView.snp.makeConstraints {
            $0.top.equalTo(segmented.snp.bottom).offset(Constants.topOffset)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.margins)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(Constants.margins)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
    }

}

extension QuizViewController {

    func configureCollectionView() {
        quizListCollectionView.register(QuizListCollectionViewCell.self,
                                        forCellWithReuseIdentifier: QuizListCollectionViewCell.reuseIdentifier)
        quizListCollectionView.collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider: { (_, _) -> NSCollectionLayoutSection? in
                let size = NSCollectionLayoutSize(
                    widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                    heightDimension: NSCollectionLayoutDimension.absolute(150)
                )
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                section.interGroupSpacing = 10
                return section
            })
    }

}
