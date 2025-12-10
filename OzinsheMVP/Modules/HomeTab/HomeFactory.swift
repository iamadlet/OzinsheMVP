import UIKit

final class HomeFactory {
    func make() -> UIViewController {
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
            moviesService: moviesService
        )
        
        let vc = HomeViewController(presenter: presenter)
        presenter.view = vc
        
        return vc
    }
}
