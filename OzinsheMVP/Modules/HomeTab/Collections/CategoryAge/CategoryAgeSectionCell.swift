import UIKit
import SnapKit

final class CategoryAgeSectionCell: UITableViewCell {
    static let identifier = "CategoryAgeSectionCell"
    
    weak var presenter: HomePresenterProtocol?
    var sectionIndex: Int = 2
    
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
        layout.itemSize = CGSize(width: 184, height: 112)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(CategoryAgeCollectionViewCell.self, forCellWithReuseIdentifier: CategoryAgeCollectionViewCell.identifier)
        return cv
    }()
}

extension CategoryAgeSectionCell {
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

extension CategoryAgeSectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.categoryAgeCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryAgeCollectionViewCell.identifier, for: indexPath) as? CategoryAgeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let model = presenter?.categoryAge(at: indexPath.item) {
            cell.configureCell(with: model)
        }
        
        return cell
    }
}
