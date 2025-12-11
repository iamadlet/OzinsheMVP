import UIKit

final class CategoryMoviesFactory {
    func make(with source: MoviesPageSource) -> UIViewController {
        let router = CategoryMoviesRouter()
        let moviesService = MoviesService(networkClient: NetworkClient(host: "apiozinshe.mobydev.kz", token: Secrets.apiKey))
        
        let presenter = CategoryMoviesPresenter(router: router, moviesService: moviesService)
        
        let vc = CategoryMoviesViewController(presenter: presenter, source: source)
        presenter.view = vc
        
        presenter.loadMovies(by: source)
        
        return vc
    }
}
