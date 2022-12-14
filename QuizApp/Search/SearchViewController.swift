import Combine
import UIKit
import SnapKit

class SearchViewController: UIViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<CategorySection, QuizModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CategorySection, QuizModel>

    private let topOffset = 20
    private let margins = 10
    private let height = 30
    private let searchBarHeight = 45
    private let errorViewConst = 200

    private lazy var dataSource = makeDataSource()
    private var cancellables = Set<AnyCancellable>()

    private var quizViewModel: QuizViewModel
    private var gradientLayer: BackgroundGradient!
    private var titleLabel: UILabel!
    private var collectionView: UICollectionView!
    private var quizErrorView: QuizErrorView!
    private var searchBar: SearchBarView!

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
        bindViews()
        configureCollectionView()
        quizViewModel.getAllQuizzes()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        guard let gradient = gradientLayer else { return }

        gradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
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
                description: "There are no available quizzes.")
            quizErrorView.isHidden = false
        }
    }

    func bindViews() {
        searchBar
            .textField
            .textDidBeginEditing
            .sink { [weak self] _ in
                self?.searchBar.textField.layer.borderWidth = 1
            }
            .store(in: &cancellables)

        searchBar
            .textField
            .textDidEndEditing
            .sink { [weak self] _ in
                self?.searchBar.textField.layer.borderWidth = 0
            }
            .store(in: &cancellables)
    }

    func bindViewModel() {
        quizViewModel
            .$quizError
            .compactMap { $0 }
            .sink { [weak self] quizError in
                self?.handleNoQuizzesAvailable(error: quizError)
            }
            .store(in: &cancellables)

        quizViewModel
            .$quizzes
            .sink { [weak self] quizzes in
                guard let self = self else { return }

                self.applySnapshot(quizzes: quizzes)
                self.quizErrorView.isHidden = !quizzes.isEmpty
            }
            .store(in: &cancellables)
    }

}

extension SearchViewController: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        gradientLayer = BackgroundGradient()
        view.layer.addSublayer(gradientLayer)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureLayout())
        view.addSubview(collectionView)

        searchBar = SearchBarView()
        view.addSubview(searchBar)

        quizErrorView = QuizErrorView()
        view.addSubview(quizErrorView)
    }

    func styleViews() {
        gradientLayer.setBackground()

        searchBar.textField.delegate = self

        collectionView.backgroundColor = .clear

        quizErrorView.isHidden = true
    }

    func defineLayoutForViews() {
        gradientLayer.frame = view.bounds

        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-topOffset)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(searchBarHeight)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(margins)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        quizErrorView.snp.makeConstraints {
            $0.width.equalTo(errorViewConst)
            $0.height.equalTo(errorViewConst)
            $0.center.equalToSuperview()
        }
    }

}

extension SearchViewController: UICollectionViewDelegate {

    func configureCollectionView() {
        collectionView.delegate = self

        collectionView.register(QuizListCollectionViewCell.self,
                                forCellWithReuseIdentifier: QuizListCollectionViewCell.reuseIdentifier)

        collectionView.register(
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
            guard !filteredQuizzes.isEmpty else { return }

            snapshot.appendSections([section])
            snapshot.appendItems(filteredQuizzes, toSection: section)
        }

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedQuiz = dataSource.itemIdentifier(for: indexPath) else { return }

        quizViewModel.showQuizDetails(quiz: selectedQuiz)
    }

}

extension SearchViewController: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        let quizzes = filteredQuizzes(for: textField.text)
        applySnapshot(quizzes: quizzes)
    }

    func filteredQuizzes(for text: String?) -> [QuizModel] {
        let quizzes = quizViewModel.quizzes
        guard let text = text, !text.isEmpty else {
            return quizzes
        }

        let filteredQuizzes = quizzes.filter { $0.name.lowercased().contains(text.lowercased()) }
        return filteredQuizzes
    }

}
