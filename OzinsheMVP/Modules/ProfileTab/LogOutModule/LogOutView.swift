import UIKit
import SnapKit

final class LogOutView: UIView {
    private let presenter: LogOutPresenterProtocol
    
    init(presenter: LogOutPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var logOutLabel = {
        let logOutLabel = UILabel()
        logOutLabel.text = "Log out"
        logOutLabel.textColor = UIColor(named: "#111827")
        logOutLabel.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return logOutLabel
    }()
    
    lazy var logOutSubtitleLabel = {
        let logOutSubtitleLabel = UILabel()
        logOutSubtitleLabel.text = "Are you sure you want to log out?"
        logOutSubtitleLabel.textColor = UIColor(named: "#9CA3AF")
        logOutSubtitleLabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        return logOutSubtitleLabel
    }()
    
    lazy var logOutButton = {
        let button = UIButton()
        
        button.setTitle("Yes, log out", for: .normal)
        button.backgroundColor = UIColor(named: "#7E2DFC")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var cancelLogOutButton = {
        let button = UIButton()
        
        button.setTitle("No", for: .normal)
        button.backgroundColor = UIColor(named: "#FFFFFF 1")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
        button.setTitleColor(UIColor(named: "#7E2DFC"), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(cancelLogOutButtonTapped), for: .touchUpInside)
        
        return button
    }()
}

extension LogOutView {
    func commonInit() {
        self.backgroundColor = UIColor(named: "#FFFFFF 1")
        setupSubviews()
        setupConstraints()
    }
    
    @objc func logOutButtonTapped() {
        presenter.didTapLogOut()
    }
    
    @objc func cancelLogOutButtonTapped() {
        presenter.didTapCancel()
    }
    
    func setupSubviews() {
        self.addSubviews(logOutLabel, logOutSubtitleLabel, logOutButton, cancelLogOutButton)
    }
    
    func setupConstraints() {
        logOutLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(58)
            make.leading.equalToSuperview().inset(24)
        }
        
        logOutSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(logOutLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
        }
        
        cancelLogOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        logOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(cancelLogOutButton.snp.top).offset(-8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
}
