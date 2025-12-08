import UIKit
import SnapKit

class PersonalInfoView: UIView {
    
    private let presenter: PersonalInfoPresenterProtocol
    
    init(presenter: PersonalInfoPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Name Elements
    lazy var nameLabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "#9CA3AF")
        return label
    }()
    
    lazy var nameTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter your name..."
        textfield.textColor = UIColor(named: "#111827")
        textfield.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return textfield
    }()
    
    lazy var grayView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#D1D5DB")
        return view
    }()
    
    // MARK: - Email Elements
    lazy var emailLabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "#9CA3AF")
        return label
    }()
    
    lazy var emailTextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter your email..."
        textfield.textColor = UIColor(named: "#111827")
        textfield.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return textfield
    }()
    
    lazy var grayView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#D1D5DB")
        return view
    }()
    
    // MARK: - Phone number elements
    lazy var phoneLabel = {
        let label = UILabel()
        label.text = "Phone number"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "#9CA3AF")
        return label
    }()
    
    lazy var phoneTextField = {
        let textfield = UITextField()
        textfield.keyboardType = .numberPad
        textfield.placeholder = "Enter your phone number..."
        textfield.textColor = UIColor(named: "#111827")
        textfield.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return textfield
    }()
    
    lazy var grayView3 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#D1D5DB")
        return view
    }()
    
    // MARK: - Date of Birth elements
    lazy var birthdayLabel = {
        let label = UILabel()
        label.text = "Date of birth"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "#9CA3AF")
        return label
    }()
    
    lazy var birthdayPicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .date
        return picker
    }()
    
    lazy var grayView4 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#D1D5DB")
        return view
    }()
    
    // MARK: - Gray view under the Navigation Bar
    lazy var grayView5 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "#D1D5DB")
        return view
    }()
    
    // MARK: - Save Changes Button
    lazy var saveChangesButton = {
        let button = UIButton()
        
        button.setTitle("Save Changes", for: .normal)
        button.backgroundColor = UIColor(named: "#7E2DFC")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-SemiBold", size: 16)
        button.layer.cornerRadius = 12
//        button.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)
        
        return button
    }()
}

extension PersonalInfoView {
    func commonInit() {
        self.backgroundColor = UIColor(named: "#F9FAFB")
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        self.addSubviews(nameLabel, nameTextField, grayView, emailLabel, emailTextField, grayView2, phoneLabel, phoneTextField, grayView3, birthdayLabel, birthdayPicker, grayView4, grayView5, saveChangesButton)
    }
    
    func setupConstraints() {
        grayView5.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView5.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        grayView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        grayView2.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView2.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        grayView3.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.leading.trailing.equalTo(1)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView3.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
        }
        
        birthdayPicker.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
        }
        
        grayView4.snp.makeConstraints { make in
            make.top.equalTo(birthdayPicker.snp.bottom).offset(12)
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(8)
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
        }
    }
}
