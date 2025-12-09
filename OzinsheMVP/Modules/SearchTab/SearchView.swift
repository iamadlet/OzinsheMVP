import UIKit
import SnapKit

final class SearchView: UIView {
    private let presenter: SearchPresenterProtocol
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let searchTextField = {
        let searchTF = TextFieldWithPadding()
        
        searchTF.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        searchTF.placeholder = "Search"
        searchTF.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        searchTF.textColor = UIColor(named: "111827")
        searchTF.layer.borderWidth = 1.0
        searchTF.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        searchTF.layer.cornerRadius = 12.0
        
        return searchTF
    }()
    
    lazy var exitButton = {
        let exitBut = UIButton()
        
        exitBut.setImage(UIImage(named: "exitButton"), for: .normal)
        exitBut.contentMode = .scaleToFill
        exitBut.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        
        return exitBut
    }()
    
    lazy var searchButton = {
        let searchBut = UIButton()
        
        searchBut.setImage(UIImage(named: "searchVC"), for: .normal)
        searchBut.contentMode = .scaleToFill
        searchBut.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        return searchBut
    }()
    
    let titleLabel = {
        let label = UILabel()
        
        label.text = "Categories"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827")
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 128, height: 34)
        layout.estimatedItemSize.width = 100
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.backgroundColor = UIColor(named: "FFFFFF")
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = UIColor(named: "FFFFFF")
        //Регистрация table view cell
        tv.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        return tv
    }()
}

extension SearchView {
    func commonInit() {
        self.backgroundColor = UIColor(named: "#FFFFFF")
    }
    
    @objc func clearTextField() {
        searchTextField.text = ""
    }
    
    @objc func searchButtonTapped() {
        self.collectionView.isHidden = true
        self.tableView.reloadData()
    }
    
    func setupSubviews() {
        self.addSubviews(searchButton, searchTextField, exitButton, titleLabel, collectionView, tableView)
    }
    
    func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(96)
            make.height.equalTo(56)
            make.width.equalTo(255)
        }
        
        exitButton.snp.makeConstraints { make in
            
            make.height.equalTo(52)
            make.width.equalTo(52)
            make.right.equalTo(searchTextField.snp.right).offset(0)
            make.centerY.equalTo(searchTextField)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.right.equalToSuperview().inset(24)
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(28)
            make.top.equalTo(searchTextField.snp.bottom).offset(35)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.right.left.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(340)
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(self.safeAreaLayoutGuide)
        }

    }
}
