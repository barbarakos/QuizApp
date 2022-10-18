import Foundation
import UIKit
import SnapKit
import Combine

class QuizViewController: UIViewController {

    var gradientBg: CAGradientLayer!
    var titleLabel: UILabel!
    var segmented: UISegmentedControl!

    var quizListCollectionView: UICollectionView!

    private var quizViewModel: QuizViewModel!
    private var cancellables = Set<AnyCancellable>()

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
        newCategoryChosen()
    }

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    @objc func newCategoryChosen() {
        guard let category = segmented.titleForSegment(at: segmented.selectedSegmentIndex) else { return }
        quizViewModel.getQuizzes(for: category.uppercased())
    }

    @MainActor
    func bindViewModel() {
        quizViewModel
            .$mockQuizzes
            .sink { [weak self] _ in
                self?.quizListCollectionView.reloadData()
            }
            .store(in: &cancellables)
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

        segmented.addTarget(self, action: #selector(newCategoryChosen), for: .valueChanged)
        segmented.layer.cornerRadius = 10
        segmented.selectedSegmentIndex = 0
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmented.setTitleTextAttributes(titleAttributes, for: .normal)
        segmented.setTitleTextAttributes(titleAttributes, for: .selected)
        segmented.apportionsSegmentWidthsByContent = true
        segmented.selectedSegmentTintColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1)
        segmented.backgroundColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 0.5)

        quizListCollectionView.layer.cornerRadius = 7
        configureCollectionView()
    }

    func defineLayoutForViews() {
        gradientBg.frame = view.bounds
        gradientBg.locations = [0, 1]

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(-30)
            $0.height.equalTo(30)
        }

        segmented.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(10)
            $0.height.equalTo(30)
        }

        quizListCollectionView.snp.makeConstraints {
            $0.top.equalTo(segmented.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(10)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).inset(10)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(5)
        }
    }

}

extension QuizViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizViewModel.mockQuizzes.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizListCollectionViewCell.id,
                                                      for: indexPath) as? QuizListCollectionViewCell
        cell!.set(for: quizViewModel.mockQuizzes[indexPath.row])
        return cell!
    }

    func configureCollectionView() {
        quizListCollectionView.register(QuizListCollectionViewCell.self,
                                        forCellWithReuseIdentifier: QuizListCollectionViewCell.id)
        quizListCollectionView.backgroundColor = .clear
        quizListCollectionView.delegate = self
        quizListCollectionView.dataSource = self
        quizListCollectionView.isScrollEnabled = true
//        quizListCollectionView.isPagingEnabled = true
    }

}

extension QuizViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 150)
    }

}
