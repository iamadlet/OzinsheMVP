import UIKit
import SnapKit

class ProfileView: UIView {
    
    private let presenter: ProfilePresenterProtocol
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var profileImageView = {
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "Avatar")
        return profileImageView
    }()
    
    lazy var profileLabel = {
        let label = UILabel()
        label.text = "My Profile"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "#111827")
        return label
    }()
    
    lazy var subtitleProfileLabel = {
        let label = UILabel()
        label.text = "ali@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    lazy var backView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#F9FAFB")
        return view
    }()
    
    // MARK: - Language Button Elements
    lazy var languageButton = {
        let button = UIButton()
        button.setTitle("Language", for: .normal)
        button.setTitleColor(UIColor(named: "#1C2431"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(changeLanguageButtonTappedAction), for: .touchUpInside)
        return button
    }()
    
    lazy var languageLabel = {
        let label = UILabel()
        label.text = "English"
        label.textColor = UIColor(named: "#9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        return label
    }()
    
    lazy var languageArrowImage = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "profileArrow")
        return arrowImage
    }()
    
    lazy var languageCellView = {
        let cell = UIView()
        
        cell.backgroundColor = UIColor(named: "#D1D5DB")
        
        return cell
    }()

    // MARK: - User Info Button Elements
    lazy var userInfoButton = {
        let button = UIButton()
        button.setTitle("Personal Information", for: .normal)
        button.setTitleColor(UIColor(named: "#1C2431"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(personalInfoButtonTappedAction), for: .touchUpInside)
        return button
    }()
    
    lazy var userInfoLabel = {
        let label = UILabel()
        label.text = "Edit"
        label.textColor = UIColor(named: "#9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        return label
    }()
    
    lazy var userInfoArrowImage = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "profileArrow")
        return arrowImage
    }()
    
    lazy var userInfoCell = {
        let cell = UIView()
        cell.backgroundColor = UIColor(named: "#D1D5DB")
        return cell
    }()
    
    // MARK: - Change Password Button Elements
    lazy var changePasswordButton = {
        let button = UIButton()
        button.setTitle("Change Password", for: .normal)
        button.setTitleColor(UIColor(named: "#1C2431"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(changePasswordButtonTappedAction), for: .touchUpInside)
        return button
    }()
    
    lazy var changePasswordLabel = {
        let label = UILabel()
        label.text = "Edit"
        label.textColor = UIColor(named: "#9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        return label
    }()
    
    lazy var changePasswordArrowImage = {
        let arrowImage = UIImageView()
        arrowImage.image = UIImage(named: "profileArrow")
        return arrowImage
    }()
    
    lazy var changePasswordCell = {
        let cell = UIView()
        cell.backgroundColor = UIColor(named: "#D1D5DB")
        return cell
    }()
    
    //MARK: - Dark Mode Elements
    
    lazy var darkModeLabel = {
        let label = UILabel()
        label.text = "Dark Mode"
        label.textColor = UIColor(named: "#1C2431")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        return label
    }()
    
    
    lazy var darkModeSwitch = {
        let dmSwitch = UISwitch()
        dmSwitch.onTintColor = .tintColor
        dmSwitch.addTarget(self, action: #selector(changeSwitch(_:)), for: .valueChanged)
        return dmSwitch
    }()
}

extension ProfileView {
    func commonInit() {
        self.backgroundColor = UIColor(named: "#FFFFFF")
        languageLabel.text = UserDefaults.standard.string(forKey: Keys.selectedLanguage) ?? "English"
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.addSubviews(profileImageView, profileLabel, subtitleProfileLabel, backView)
        
        backView.addSubviews(languageLabel, languageButton, languageCellView, languageArrowImage, userInfoLabel, userInfoButton, userInfoArrowImage, userInfoCell, changePasswordLabel, changePasswordButton, changePasswordArrowImage, changePasswordCell, darkModeSwitch, darkModeLabel)
    }
    
    @objc func personalInfoButtonTappedAction() {
        presenter.didSelectPersonalInfo()
    }
    
    @objc func changePasswordButtonTappedAction() {
        presenter.didSelectChangePassword()
    }
    
    @objc func changeLanguageButtonTappedAction() {
        presenter.didSelectChangeLanguage()
    }
    
    @objc func changeSwitch(_ dmSwitch: UISwitch) {
        presenter.didToggleThemeSwitch(isOn: dmSwitch.isOn)
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(24)
            make.centerX.equalToSuperview()
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        subtitleProfileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        backView.snp.makeConstraints { make in
            make.top.equalTo(subtitleProfileLabel.snp.bottom).offset(24)
            make.bottom.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        // MARK: - User Info Constraints
        userInfoButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
//            make.bottom.equalTo(userInfoCell.snp.top).offset(1)
            make.height.equalTo(64)
        }
        
        userInfoArrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(16)
            make.leading.equalTo(userInfoLabel.snp.trailing).offset(8)
            make.centerY.equalTo(userInfoButton)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userInfoButton)
        }
        
        userInfoCell.snp.makeConstraints { make in
            make.top.equalTo(userInfoButton.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        // MARK: - Change Password Constraints
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(userInfoCell.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        changePasswordArrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(16)
            make.leading.equalTo(changePasswordLabel.snp.trailing).offset(8)
            make.centerY.equalTo(changePasswordButton)
        }
        
        changePasswordLabel.snp.makeConstraints { make in
            make.centerY.equalTo(changePasswordButton)
        }
        
        changePasswordCell.snp.makeConstraints { make in
            make.top.equalTo(changePasswordButton.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        //MARK: - Language Constraints
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(changePasswordCell.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(64)
        }
        
        languageArrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.height.width.equalTo(16)
            make.leading.equalTo(languageLabel.snp.trailing).offset(8)
            make.centerY.equalTo(languageButton)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.centerY.equalTo(languageButton)
        }
        
        languageCellView.snp.makeConstraints { make in
            make.top.equalTo(languageButton.snp.bottom)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        // MARK: - Dark Mode Constraints
        darkModeLabel.snp.makeConstraints { make in
            make.top.equalTo(languageCellView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(24)
            make.centerY.equalTo(darkModeSwitch)
        }
        
        darkModeSwitch.snp.makeConstraints { make in
            make.top.equalTo(languageCellView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(24)
            
        }
    }
}
