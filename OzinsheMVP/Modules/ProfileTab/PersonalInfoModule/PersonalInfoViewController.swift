import UIKit

protocol PersonalInfoViewProtocol: AnyObject {
    func saveChangesButtonTapped()
    func showUserProfile()
}

final class PersonalInfoViewController: UIViewController {
    private let presenter: PersonalInfoPresenterProtocol
    private lazy var profileView = PersonalInfoView(presenter: presenter)
    
    init(presenter: PersonalInfoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Personal Info"
        let backButton = UIBarButtonItem(
            image: UIImage(named: "back.arrow"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = UIColor(named: "#111827")
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        presenter.loadUserProfile()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension PersonalInfoViewController: PersonalInfoViewProtocol {
    func saveChangesButtonTapped() {
        presenter.saveChanges()
    }
    
    func showUserProfile() {
        profileView.emailTextField.text = presenter.getUser()?.email
        profileView.nameTextField.text = presenter.getUser()?.name
        profileView.phoneTextField.text = presenter.getUser()?.phoneNumber
        profileView.birthdayPicker.date = stringToDate(presenter.getUser()?.birthDate)
    }
    
    private func stringToDate(_ string: String?) -> Date {
        guard let string = string else {
            return Date()
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.date(from: string) ?? Date()
    }
}
