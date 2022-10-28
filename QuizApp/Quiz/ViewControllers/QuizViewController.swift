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
    var quizErrorView: QuizErrorView!

    private let topOffset = 20
    private let margins = 10
    private let height = 30
    private let errorViewConst = 200

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
    }

    @objc func didSelectCategory() {
        guard
            let category = categorySegmentedControl.titleForSegment(at: categorySegmentedControl.selectedSegmentIndex)
        else { return }

        let allCategories = CategorySection.allCases.map { $0.rawValue }
        if allCategories.contains(category) {
            quizViewModel.getQuizzes(for: category.uppercased())
        } else {
            quizViewModel.getAllQuizzes()
        }
    }

    func handleNoQuizzesAvailable(error: QuizError) {
        if error == .serverError {
            quizErrorView.set(
                title: "Error",
                description: "Data can't be reached. Please try again.")
            quizErrorView.isHidden = false
        } else {
            quizErrorView.set(
                title: "No data",
                description: "There are no available quizzes for this category.")
            quizErrorView.isHidden = false
        }
    }

    func bindViewModel() {
        quizViewModel
            .$quizError
            .sink { [weak self] quizError in
                if let error = quizError {
                    self?.handleNoQuizzesAvailable(error: error)
                }
            }
            .store(in: &cancellables)

        quizViewModel
            .$quizzes
            .sink { [weak self] quizzes in
                guard let self = self else { return }

                self.applySnapshot(quizzes: quizzes)
                if !quizzes.isEmpty {
                    self.quizErrorView.isHidden = true
                }
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

        let items = ["All"] + CategorySection.allCases.map {$0.rawValue}
        categorySegmentedControl = UISegmentedControl(items: items)
        view.addSubview(categorySegmentedControl)

        quizListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        view.addSubview(quizListCollectionView)

        quizErrorView = QuizErrorView()
        view.addSubview(quizErrorView)
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

        quizErrorView.isHidden = true
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
            $0.leading.trailing.bottom.equalToSuperview()
        }

        quizErrorView.snp.makeConstraints {
            $0.width.equalTo(errorViewConst)
            $0.height.equalTo(errorViewConst)
            $0.center.equalToSuperview()
        }
    }

}

extension QuizViewController {

    func configureCollectionView() {
        quizListCollectionView.register(QuizListCollectionViewCell.self,
                                        forCellWithReuseIdentifier: QuizListCollectionViewCell.reuseIdentifier)

        quizListCollectionView.register(
            SectionHeaderReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier)
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
                let headerFooterSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(20))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            })
        return layout
    }

    func applySnapshot(quizzes: [QuizModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        CategorySection.allCases.forEach { section in
            let filteredQuizzes = quizzes.filter { $0.category == section.rawValue.uppercased() }
            if !filteredQuizzes.isEmpty {
                snapshot.appendSections([section])
                snapshot.appendItems(filteredQuizzes, toSection: section)
            }
        }

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

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader,
                  let view = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SectionHeaderReusableView.reuseIdentifier,
                    for: indexPath) as? SectionHeaderReusableView
            else { return nil }

            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            view.setTitle(title: section.rawValue, color: section.color)
            return view
        }

        return dataSource
    }

}
