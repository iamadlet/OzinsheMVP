import UIKit
import SnapKit

final class MoviesSectionCell: UITableViewCell {
    static let identifier = "MoviesSectionCell"
    
    weak var presenter: HomePresenterProtocol?
    var sectionIndex: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSize(width: 112, height: 224)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        return cv
    }()
}

extension MoviesSectionCell {
    func configure(presenter: HomePresenterProtocol, sectionIndex: Int) {
        self.presenter = presenter
        self.sectionIndex = sectionIndex
        collectionView.reloadData()
    }
    
    func commonInit() {
        setupSubviews()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MoviesSectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.moviesByCategoryCount(at: sectionIndex) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let model = presenter?.movieByCategory(at: indexPath.item, sectionIndex: sectionIndex) {
            cell.configureCell(with: model)
        }
        
        return cell
    }
}

