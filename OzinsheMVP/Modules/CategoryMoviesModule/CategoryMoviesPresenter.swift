import Foundation

protocol CategoryMoviesPresenterProtocol: AnyObject {
    func loadMovies(by source: MoviesPageSource)
    func numberOfMovies() -> Int
    func movie(at index: Int) -> Movie
}

final class CategoryMoviesPresenter {
    private let router: CategoryMoviesRouterProtocol
    private let moviesService: MoviesServiceProtocol
    weak var view: CategoryMoviesViewProtocol?
    
    private var movies: [Movie] = [] {
        didSet {
            view?.reloadTableView()
        }
    }
    
    init(router: CategoryMoviesRouterProtocol, moviesService: MoviesServiceProtocol) {
        self.router = router
        self.moviesService = moviesService
    }
}

extension CategoryMoviesPresenter: CategoryMoviesPresenterProtocol {
    func loadMovies(by source: MoviesPageSource) {
        moviesService.fetchMoviesById(source: source) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.view?.showMovies()
                case .failure(let error):
                    print("Error while loading movies: \(error)")
                    print("Localized: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func numberOfMovies() -> Int {
        movies.count
    }
    
    func movie(at index: Int) -> Movie {
        movies[index]
    }
    
    
}
