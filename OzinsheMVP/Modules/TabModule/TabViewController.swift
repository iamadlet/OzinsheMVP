import UIKit

protocol TabViewProtocol: AnyObject {
    func setControllers(_ controllers: [UIViewController])
}

final class TabViewController: UITabBarController {
    private let presenter: TabViewPresenterProtocol
    
    init(presenter: TabViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewControllers == nil || viewControllers?.isEmpty == true {
            presenter.viewDidLoad()
        }
    }
}

extension TabViewController: TabViewProtocol {
    func setControllers(_ controllers: [UIViewController]) {
        setViewControllers(controllers, animated: false)
    }
}
