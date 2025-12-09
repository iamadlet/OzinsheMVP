import UIKit

final class SearchFactory {
    func make() -> UIViewController {
        // MARK: - Change return object in future...
        let router = SearchRouter()
        
        let categoriesService = CategoriesService(networkCLient: NetworkClient(host: "apiozinshe.mobydev.kz", token: Secrets.apiKey))
        
        let presenter = SearchPresenter(router: router, categoriesService: categoriesService)
        let vc = SearchViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
