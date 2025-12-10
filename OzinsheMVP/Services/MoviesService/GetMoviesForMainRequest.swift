import Foundation

struct GetMoviesForMainRequest: ApiRequestProtocol {
    typealias Response = [MoviesForMain]
    
    var endpoint: String { "/core/V1/movies/main" }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}

struct MoviesForMain: Decodable {
    let categoryId: Int
    let categoryName: String
    let movies: [MovieDTO]
}
