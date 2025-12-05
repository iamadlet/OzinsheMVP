import UIKit

final class ChangePasswordFactory {
    func make() -> UIViewController {
        let presenter = ChangePasswordPresenter()
        
        let vc = ChangePasswordViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
