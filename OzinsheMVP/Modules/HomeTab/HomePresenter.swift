import Foundation

protocol HomePresenterProtocol: AnyObject {
    var numberOfSections: Int { get }
    var bannerCount: Int { get }
    var continueWatchingCount: Int { get }
    var categoryAgeCount: Int { get }
    var genresCount: Int { get }
    func section(at index: Int) -> HomeSection
    
    func banner(at index: Int) -> Movie
    func loadMainMovies()
    
    func continueWatching(at index: Int) -> Movie
    func loadHistory()
    
    func categoryAge(at index: Int) -> CategoryAge
    func loadCategoryAges()
    
    func genre(at index: Int) -> Genre
    func loadGenres()
    
    func loadMainCategories()
    func moviesByCategoryCount(at sectionIndex: Int) -> Int
    func movieByCategory(at itemIndex: Int, sectionIndex: Int) -> Movie
    
    func openMoviesTablePage(_ source: MoviesPageSource)
}

final class HomePresenter {
    private let mainMoviesService: MainMoviesServiceProtocol
    private let historyService: HistoryServiceProtocol
    private let categoriesService: CategoriesServiceProtocol
    private let genresService: GenresServiceProtocol
    private let moviesService: MoviesServiceProtocol
    
    private let router: HomeRouterProtocol
    
    init(mainMoviesService: MainMoviesServiceProtocol, historyService: HistoryServiceProtocol, categoriesService: CategoriesServiceProtocol, genresService: GenresServiceProtocol, moviesService: MoviesServiceProtocol, router: HomeRouterProtocol) {
        self.mainMoviesService = mainMoviesService
        self.historyService = historyService
        self.categoriesService = categoriesService
        self.genresService = genresService
        self.moviesService = moviesService
        self.router = router
    }
    
    weak var view: HomeViewProtocol?
    
    private var homeSections: [HomeSection] = []
    
    private var didLoadMain = false
    private var didLoadHistory = false
    private var didLoadCategoryAges = false
    private var didLoadGenres = false
    private var didLoadMovies = false
}


extension HomePresenter: HomePresenterProtocol {
    var numberOfSections: Int {
        print("📌 numberOfSections = \(homeSections.count)")
        return homeSections.count
    }
    
    func section(at index: Int) -> HomeSection {
        homeSections[index]
    }
    
    // MARK: - Banner Methods
    func loadMainMovies() {
        let request = GetMainMoviesRequest()
        
        mainMoviesService.fetchMainMovies(request: request) { [weak self] result in
            guard let self = self else { return }
            guard !didLoadMain else { return }
            didLoadMain = true
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.homeSections.append(.banner(movies))
                    self.homeSections.sort { $0.order < $1.order }
                    self.view?.showBanner()
                case .failure(let error):
                    print("Error while loading main movies: \(error)")
                }
            }
        }
    }
    
    var bannerCount: Int {
        guard let section = homeSections.first(where: {
            if case .banner = $0 { return true }
            return false
        }) else { return 0 }
        
        if case .banner(let movies) = section {
            return movies.count
        }
        
        return 0
    }
    
    func banner(at index: Int) -> Movie {
        for section in homeSections {
            if case .banner(let movies) = section {
                return movies[index]
            }
        }
        return [] as! Movie
    }
    
    // MARK: - Continue Watching methods
    func loadHistory() {
        let request = GetUserHistoryRequest()
        
        historyService.fetchUserHistory(request: request) { [weak self] result in
            guard let self = self else { return }
            guard !self.didLoadHistory else { return }
            self.didLoadHistory = true
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.homeSections.append(.continueWatching(movies))
                    self.homeSections.sort { $0.order < $1.order }
                    self.view?.showHistory()
                case .failure(let error):
                    print("Error while loading history: \(error)")
                }
            }
        }
    }
    
    var continueWatchingCount: Int {
        guard let section = homeSections.first(where: {
            if case .continueWatching = $0 { return true }
            return false
        }) else { return 0 }
        
        if case .continueWatching(let movies) = section {
            return movies.count
        }
        
        return 0
    }
    
    func continueWatching(at index: Int) -> Movie {
        for section in homeSections {
            if case .continueWatching(let movies) = section {
                return movies[index]
            }
        }
        
        return [] as! Movie
    }
    
    // MARK: - Category Age methods
    func loadCategoryAges() {
        let request = GetCategoriesAgeRequest()
        
        categoriesService.fetchCategoryAges(request: request) { [weak self] result in
            guard let self = self else { return }
            guard !self.didLoadCategoryAges else { return }
            self.didLoadCategoryAges = true
            DispatchQueue.main.async {
                switch result {
                case .success(let categoryAges):
                    self.homeSections.append(.ageCategories(categoryAges))
                    self.homeSections.sort { $0.order < $1.order }
                    self.view?.showCategoryAges()
                case .failure(let error):
                    print("Error while loading category ages: \(error)")
                }
            }
        }
    }
    
    var categoryAgeCount: Int {
        guard let section = homeSections.first(where: {
            if case .ageCategories = $0 { return true }
            return false
        }) else { return 0 }
        
        if case .ageCategories(let categories) = section {
            return categories.count
        }
        
        return 0
    }
    
    func categoryAge(at index: Int) -> CategoryAge {
        for section in homeSections {
            if case .ageCategories(let categories) = section {
                return categories[index]
            }
        }
        
        return [] as! CategoryAge
    }
    
    // MARK: - Genre Methods
    func loadGenres() {
        let request = GetGenresRequest()
        
        genresService.fetchGenres(request: request) { [weak self] result in
            guard let self = self else { return }
            guard !self.didLoadGenres else { return }
            self.didLoadGenres = true
            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self.homeSections.append(.genres(genres))
                    self.homeSections.sort { $0.order < $1.order }
                    self.view?.showGenres()
                case .failure(let error):
                    print("Error while loading genres: \(error)")
                }
            }
        }
    }
    
    var genresCount: Int {
        guard let section = homeSections.first(where: {
            if case .genres = $0 { return true }
            return false
        }) else { return 0 }
        
        if case .genres(let genres) = section {
            return genres.count
        }
        
        return 0
    }
    
    func genre(at index: Int) -> Genre {
        for section in homeSections {
            if case .genres(let genres) = section {
                return genres[index]
            }
        }
        
        return [] as! Genre
    }
    
    // MARK: - Movies Methods
    func loadMainCategories() {
        let request = GetMoviesForMainRequest()
        
        moviesService.fetchMoviesForMain(request: request) { [weak self] result in
            guard let self = self else { return }
            guard !didLoadMovies else { return }
            didLoadMovies = true
            
            switch result {
            case .success(let categories):
                for (title, movies) in categories {
                    self.homeSections.append(.categoryMovies(title: title, movies: movies))
                }
                
                self.homeSections.sort { $0.order < $1.order }
                DispatchQueue.main.async {
                    // TODO: - Add Method showMovies in HomeViewController
                    self.view?.showMovies()
                }
            case .failure(let error):
                print("Error while loading movies by categories: \(error)")
            }
        }
    }
    
    func moviesByCategoryCount(at sectionIndex: Int) -> Int {
        let section = homeSections[sectionIndex]
        
        if case let .categoryMovies(_, movies) = section {
            return movies.count
        }
        return 0
    }
    
    func movieByCategory(at itemIndex: Int, sectionIndex: Int) -> Movie {
        let section = homeSections[sectionIndex]
        
        if case let .categoryMovies(_, movies) = section {
            return movies[itemIndex]
        }
        
        fatalError("movieByCategory called on non-categoryMovies section")
    }
    
    // MARK: - ROUTER METHODS
    func openMoviesTablePage(_ source: MoviesPageSource) {
        router.openMoviesTablePage(source: source)
    }
}

enum HomeSection {
    case banner([Movie]) // DONE
    case continueWatching([Movie]) // DONE
    case ageCategories([CategoryAge]) // DONE
    case genres([Genre]) // DONE
    case categoryMovies(title: String, movies: [Movie]) // DONE
    
    var order: Int {
        switch self {
        case .banner: return 0
        case .continueWatching: return 1
        case .ageCategories: return 2
        case .genres: return 3
        case .categoryMovies: return 4
        }
    }
    
    var title: String? {
        switch self {
        case .banner:
            return nil
        case .continueWatching:
            return "Continue Watching"
        case .ageCategories:
            return "Age Categories"
        case .genres:
            return "Choose Genre"
        case .categoryMovies(let title, _):
            return title
        }
    }
}
