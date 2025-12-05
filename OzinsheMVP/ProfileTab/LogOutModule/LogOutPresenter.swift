import UIKit

protocol LogOutPresenterProtocol: AnyObject {
    func didTapCancel()
    func didTapLogOut()
}

final class LogOutPresenter {
    private let router: LogOutRouterProtocol
    weak var view: LogOutViewProtocol?
    
    init(router: LogOutRouterProtocol) {
        self.router = router
    }
}

extension LogOutPresenter: LogOutPresenterProtocol {
    func didTapCancel() {
        router.dismiss()
    }
    
    func didTapLogOut() {
        
    }
}
