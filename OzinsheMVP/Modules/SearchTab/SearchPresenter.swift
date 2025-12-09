import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func loadCategories()
    func loadMoviesByName(_ name: String)
    func loadMoviesByCategoryId(_ id: Int)
    func category(at index: Int) -> Category
    func movie(at index: Int) -> Movie
    func getCategoriesCount() -> Int
    func getMoviesCount() -> Int
}

final class SearchPresenter {
    private let router: SearchRouterProtocol
    private let categoriesService: CategoriesServiceProtocol
    private let moviesService: MoviesServiceProtocol
    weak var view: SearchViewProtocol?
    
    init(router: SearchRouterProtocol, categoriesService: CategoriesServiceProtocol, moviesService: MoviesServiceProtocol) {
        self.router = router
        self.categoriesService = categoriesService
        self.moviesService = moviesService
    }
    
    private var categories: [Category] = [] {
        didSet {
            
        }
    }
    
    private var movies: [Movie] = [] {
        didSet {
            
        }
    }
}

extension SearchPresenter: SearchPresenterProtocol {
    func loadCategories() {
        let request = GetCategoriesRequest()
        
        categoriesService.fetchCategories(request: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let categories):
                    self.categories = categories
                    self.view?.showCategories()
                    print("Loaded categories:", categories.count)
                case .failure(let error):
                    print("Error while loading categories: \(error)")
                    print("Localized: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadMoviesByName(_ name: String) {
        guard !name.isEmpty else { return }
        
        let request = GetMoviesByNameRequest(term: name)
        
        moviesService.fetchMoviesByName(request: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.view?.showMovies()
                    print("Movies loaded : \(movies.count)")
                case .failure(let error):
                    print("Error while loading movies: \(error)")
                    print("Localized: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func loadMoviesByCategoryId(_ id: Int) {
        let request = GetMoviesByCategoryIdRequest(categoryId: id)
        
        moviesService.fetchMoviesByCategoryId(request: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
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
    
    func category(at index: Int) -> Category {
        categories[index]
    }
    
    func movie(at index: Int) -> Movie {
        movies[index]
    }
    
    func getCategoriesCount() -> Int {
        categories.count
    }
    
    func getMoviesCount() -> Int {
        movies.count
    }
}
