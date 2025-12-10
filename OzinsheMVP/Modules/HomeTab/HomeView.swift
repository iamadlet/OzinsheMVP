import UIKit
import SnapKit

final class HomeView: UIView {
    private let presenter: HomePresenterProtocol
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        return tableView
    }()
    
//    lazy var logoImageView: UIImageView = {
//        let image = UIImageView(image: UIImage(named: "logo"))
//        return image
//    }()
}

extension HomeView {
    func commonInit() {
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(self.safeAreaLayoutGuide).inset(16)
//            make.leading.equalToSuperview().inset(24)
//        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
