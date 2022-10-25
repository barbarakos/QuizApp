import Combine
import UIKit
import SnapKit

class QuizViewController: UIViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<CategorySection, QuizModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategorySection, QuizModel>

    var gradientLayer: CAGradientLayer!
    var titleLabel: UILabel!
    var categorySegmentedControl: UISegmentedControl!
    var quizListCollectionView: UICollectionView!

    private let topOffset = 20
    private let margins = 10
    private let height = 30

    private lazy var dataSource = makeDataSource()
    private var cancellables = Set<AnyCancellable>()
    private var quizViewModel: QuizViewModel

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
        bindViewModel()
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

    @objc func didSelectCategory() {
        guard
            let category = categorySegmentedControl.titleForSegment(at: categorySegmentedControl.selectedSegmentIndex)
        else { return }

        quizViewModel.getQuizzes(for: category.uppercased())
    }

    @MainActor
    func bindViewModel() {
        quizViewModel
            .$quizzes
            .sink { [weak self] _ in
                self?.applySnapshot()
            }
            .store(in: &cancellables)
    }

}

extension QuizViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        view.layer.addSublayer(gradientLayer)

        titleLabel = UILabel()
        view.addSubview(titleLabel)

        categorySegmentedControl = UISegmentedControl(
            items: [CategorySection.geography.title,
                    CategorySection.movies.title,
                    CategorySection.music.title,
                    CategorySection.sport.title])
        view.addSubview(categorySegmentedControl)

        quizListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        view.addSubview(quizListCollectionView)
    }

    func styleViews() {
        gradientLayer.colors = [
            UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor,
            UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor
        ]

        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white

        categorySegmentedControl.addTarget(self, action: #selector(didSelectCategory), for: .valueChanged)
        categorySegmentedControl.layer.cornerRadius = 10
        categorySegmentedControl.selectedSegmentIndex = 0
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        categorySegmentedControl.setTitleTextAttributes(titleAttributes, for: .normal)
        categorySegmentedControl.setTitleTextAttributes(titleAttributes, for: .selected)
        categorySegmentedControl.apportionsSegmentWidthsByContent = true
        categorySegmentedControl.selectedSegmentTintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
        categorySegmentedControl.backgroundColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 0.5)

        quizListCollectionView.backgroundColor = .clear
        quizListCollectionView.isScrollEnabled = true
        quizListCollectionView.layer.cornerRadius = 7
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds
        gradientLayer.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-height)
            $0.height.equalTo(height)
        }

        categorySegmentedControl.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(topOffset)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(margins)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(margins)
            $0.height.equalTo(height)
        }

        quizListCollectionView.snp.makeConstraints {
            $0.top.equalTo(categorySegmentedControl.snp.bottom).offset(topOffset)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(margins)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(margins)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
    }

}

extension QuizViewController {

    func configureCollectionView() {
        quizListCollectionView.register(QuizListCollectionViewCell.self,
                                        forCellWithReuseIdentifier: QuizListCollectionViewCell.reuseIdentifier)
    }

    func configureLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(
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
        return layout
    }

}
