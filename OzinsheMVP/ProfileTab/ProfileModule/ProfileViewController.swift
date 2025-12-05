import UIKit

protocol ProfileViewProtocol: AnyObject {
//    func personalInfoButtonTapped()
    func logOutButtonTapped()
    func setInterfaceStyle(_ style: UIUserInterfaceStyle)
//    func changeLanguageButtonTapped()
}

final class ProfileViewController: UIViewController {
    private let presenter: ProfilePresenterProtocol
    private lazy var profileView = ProfileView(presenter: presenter)
    
    init(presenter: ProfilePresenterProtocol) {
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
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "LogOut"), style: .done, target: self, action: #selector(logOutButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
    }
}

extension ProfileViewController: ProfileViewProtocol {
//    func personalInfoButtonTapped() {
//        presenter.didSelectPersonalInfo()
//    }
//    
//    func changeLanguageButtonTapped() {
//        presenter.didSelectChangeLanguage()
//    }
    
    @objc func logOutButtonTapped() {
        presenter.didSelectLogout()
    }
    
    func setInterfaceStyle(_ style: UIUserInterfaceStyle) {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        
        windowScene.windows.forEach { window in
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.overrideUserInterfaceStyle = style
            }, completion: nil)
        }
    }
}
