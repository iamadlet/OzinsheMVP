import UIKit

protocol ChangePasswordViewProtocol: AnyObject {
    
}

final class ChangePasswordViewController: UIViewController {
    private let presenter: ChangePasswordPresenterProtocol
    private lazy var passwordView = ChangePasswordView(presenter: presenter)
    
    init(presenter: ChangePasswordPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = passwordView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Change password"
        let backButton = UIBarButtonItem(
            image: UIImage(named: "back.arrow"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = UIColor(named: "#111827")
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension ChangePasswordViewController: ChangePasswordViewProtocol {
    
}
