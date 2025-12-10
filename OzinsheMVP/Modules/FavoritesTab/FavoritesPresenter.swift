import UIKit

protocol FavoritesPresenterProtocol: AnyObject {
    func loadFavorites()
    func numberOfFavorites() -> Int
    func movie(at index: Int) -> Movie
}

final class FavoritesPresenter {
    private let router: FavoritesRouterProtocol
    private let favoritesService: FavoritesServiceProtocol
    weak var view: FavoritesViewProtocol?
    
    private var favoriteMovies: [Movie] = [] {
        didSet {
            view?.reloadTableView()
        }
    }
    
    init(router: FavoritesRouterProtocol, favoritesService: FavoritesServiceProtocol) {
        self.router = router
        self.favoritesService = favoritesService
    }
}

extension FavoritesPresenter: FavoritesPresenterProtocol {
    func loadFavorites() {
        let request = GetFavoriteMoviesRequest()
        
        favoritesService.fetchFavoriteMovies(request: request) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let favorites):
                    self.favoriteMovies = favorites
                    self.view?.reloadTableView()
                case .failure(let error):
                    print("Error while loading favorites: \(error)")
                }
            }
        }
    }
    
    func numberOfFavorites() -> Int {
        favoriteMovies.count
    }
    
    func movie(at index: Int) -> Movie {
        favoriteMovies[index]
    }
}
