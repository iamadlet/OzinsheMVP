import UIKit

protocol LogOutRouterProtocol: AnyObject {
    func dismiss()
}

final class LogOutRouter: LogOutRouterProtocol {
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
