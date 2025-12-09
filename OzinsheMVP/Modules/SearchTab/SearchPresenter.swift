import UIKit

protocol SearchPresenterProtocol: AnyObject {
    func loadCategories()
    func loadMovies()
    func category(at index: Int) -> Category
    func movie(at index: Int) -> Movie
}

final class SearchPresenter {
    private let router: SearchRouterProtocol
    private let categoriesService: CategoriesServiceProtocol
    weak var view: SearchViewProtocol?
    
    init(router: SearchRouterProtocol, categoriesService: CategoriesServiceProtocol) {
        self.router = router
        self.categoriesService = categoriesService
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
                case .failure(let error):
                    print("Error while loading categories: \(error)")
                }
            }
        }
    }
    
    func loadMovies() {
        
    }
    
    func category(at index: Int) -> Category {
        categories[index]
    }
    
    func movie(at index: Int) -> Movie {
        movies[index]
    }
}
