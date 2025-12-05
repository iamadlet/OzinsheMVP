import UIKit

protocol LogOutViewProtocol: AnyObject {
    
}

final class LogOutViewController: UIViewController {
    private let presenter: LogOutPresenterProtocol
    private lazy var logOutView = LogOutView(presenter: presenter)
    
    init(presenter: LogOutPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = logOutView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension LogOutViewController: LogOutViewProtocol {
    
}
