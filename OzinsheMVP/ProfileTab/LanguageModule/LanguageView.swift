import UIKit
import SnapKit

final class LanguageView: UIView {
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var langLabel = {
        let languageLabel = UILabel()
        languageLabel.text = "Language"
        languageLabel.textColor = UIColor(named: "#111827")
        languageLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return languageLabel
    }()
    
    lazy var langTableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        //Регистрация Table View Cell
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageCell")
        
        return tableView
    }()
}

extension LanguageView {
    func commonInit() {
        self.backgroundColor = UIColor(named: "#FFFFFF")
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.addSubviews(langTableView, langLabel)
    }
    
    func setupConstraints() {
        langLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().inset(24)
        }
        
        langTableView.snp.makeConstraints { make in
            make.top.equalTo(langLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}
