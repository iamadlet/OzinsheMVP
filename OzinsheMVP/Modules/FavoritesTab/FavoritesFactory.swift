import UIKit

final class FavoritesFactory {
    func make() -> UIViewController {
        let favoritesService = FavoritesService(networkClient: NetworkClient(host: "apiozinshe.mobydev.kz", token: Secrets.apiKey))
        
        let router = FavoritesRouter()
        
        let presenter = FavoritesPresenter(router: router, favoritesService: favoritesService)
        
        let vc = FavoritesViewController(presenter: presenter)
        presenter.view = vc
        
        return vc
    }
}
