import UIKit

final class LogOutFactory {
    func make() -> UIViewController {
        let router = LogOutRouter()
        
        let presenter = LogOutPresenter(router: router)
        
        let vc = LogOutViewController(presenter: presenter)
        presenter.view = vc
        router.viewController = vc
        return vc
    }
}
