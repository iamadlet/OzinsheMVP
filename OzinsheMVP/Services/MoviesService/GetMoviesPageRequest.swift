import Foundation

struct GetMoviesPageRequest: ApiRequestProtocol {
    typealias Response = ApiResponse
    
    let source: MoviesPageSource
    
    var endpoint: String { "/core/V1/movies/page" }
    
    var parameters: [URLQueryItem]? {
        switch source {
        case .category(let category):
            return [URLQueryItem(name: "categoryId", value: String(category.id))]
        case .categoryAge(let categoryAge):
            return [URLQueryItem(name: "categoryAgeId", value: String(categoryAge.id))]
        case .genre(let genre):
            return [URLQueryItem(name: "genreId", value: String(genre.id))]
        }
    }
}

enum MoviesPageSource {
    case category(Category)
    case categoryAge(CategoryAge)
    case genre(Genre)
    
    var title: String {
        switch self {
        case .category(let category):
            return category.name
        case .categoryAge(let categoryAge):
            return categoryAge.name
        case .genre(let genre):
            return genre.name
        }
    }
}
