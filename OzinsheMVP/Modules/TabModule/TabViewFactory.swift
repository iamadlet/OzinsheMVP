import UIKit

final class TabViewFactory {
    func make() -> UIViewController {
        let router = TabViewRouter(profileFactory: ProfileFactory(), favoritesFactory: FavoritesFactory(), searchFactory: SearchFactory())
        
        let presenter = TabViewPresenter(router: router)
        let vc = TabViewController(presenter: presenter)
        
        presenter.view = vc
        router.setRoot(root: vc)
        return vc
    }
}
