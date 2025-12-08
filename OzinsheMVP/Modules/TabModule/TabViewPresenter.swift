import Foundation

protocol TabViewPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class TabViewPresenter {
    weak var view: TabViewProtocol?
    private let router: TabViewRouterProtocol
    
    init(router: TabViewRouterProtocol) {
        self.router = router
    }
}

extension TabViewPresenter: TabViewPresenterProtocol {
    func viewDidLoad() {
        let tabs = router.assembleTabs()
        view?.setControllers(tabs)
    }
}
