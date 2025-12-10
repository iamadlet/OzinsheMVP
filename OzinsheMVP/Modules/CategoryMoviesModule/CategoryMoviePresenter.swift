protocol CategoryMoviePresenterProtocol: AnyObject {
    func loadMovies()
    func numberOfMovies() -> Int
    func movie(at index: Int) -> Movie
}

final class CategoryMoviePresenter {
    private let router: CategoryMoviesRouterProtocol
    // TODO: - поменять сервис на movieService
    private let favoritesService: FavoritesServiceProtocol
    weak var view: CategoryMoviesViewProtocol?
    
    private var movies: [Movie] = [] {
        didSet {
            view?.reloadTableView()
        }
    }
    
    init(router: CategoryMoviesRouterProtocol, favoritesService: FavoritesServiceProtocol) {
        self.router = router
        self.favoritesService = favoritesService
    }
}

extension CategoryMoviePresenter: CategoryMoviePresenterProtocol {
    func loadMovies() {
        
    }
    
    func numberOfMovies() -> Int {
        movies.count
    }
    
    func movie(at index: Int) -> Movie {
        movies[index]
    }
    
    
}
