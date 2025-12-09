import UIKit
import SnapKit

final class FavoritesView: UIView {
    private let presenter: FavoritesPresenterProtocol
    
    init(presenter: FavoritesPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerDivider = {
        let cell = UIView()
        
        cell.backgroundColor = UIColor(named: "#D1D5DB")
        
        return cell
    }()
    
    lazy var movieTableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        
        return tableView
    }()
}

extension FavoritesView {
    func commonInit() {
        setupSubviews()
        setupConstraints()
        self.backgroundColor = UIColor(named: "#F9FAFB")
    }
    
    func setupSubviews() {
        self.addSubviews(movieTableView, headerDivider)
    }
    
    func setupConstraints() {
        movieTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        headerDivider.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(1)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
