import UIKit

final class SearchFactory {
    func make() -> UIViewController {
        let router = SearchRouter(categoryMoviesFactory: CategoryMoviesFactory())
        
        let networkClient = NetworkClient(host: "apiozinshe.mobydev.kz", token: Secrets.apiKey)
        
        let categoriesService = CategoriesService(networkCLient: networkClient)
        let moviesService = MoviesService(networkClient: networkClient)
        
        let presenter = SearchPresenter(router: router, categoriesService: categoriesService, moviesService: moviesService)
        let vc = SearchViewController(presenter: presenter)
        presenter.view = vc
        
        router.setRootViewController(root: vc)
        
        return vc
    }
}
