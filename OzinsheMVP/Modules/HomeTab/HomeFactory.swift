import UIKit

final class HomeFactory {
    func make() -> UIViewController {
        let categoryMoviesFactory = CategoryMoviesFactory()
        
        let router = HomeRouter(categoryMoviesFactory: categoryMoviesFactory)
        
        let networkClient = NetworkClient(host: "apiozinshe.mobydev.kz", token: Secrets.apiKey)
        
        let mainMoviesService = MainMoviesService(networkClient: networkClient)
        let historyService = HistoryService(networkClient: networkClient)
        let categoriesService = CategoriesService(networkCLient: networkClient)
        let genresService = GenresService(networkClient: networkClient)
        let moviesService = MoviesService(networkClient: networkClient)
        
        let presenter = HomePresenter(
            mainMoviesService: mainMoviesService,
            historyService: historyService,
            categoriesService: categoriesService,
            genresService: genresService,
            moviesService: moviesService,
            router: router
        )
        
        let vc = HomeViewController(presenter: presenter)
        presenter.view = vc
        
        router.root = vc
        
        return vc
    }
}
