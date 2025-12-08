import Foundation

struct GetFavoriteMoviesRequest: ApiRequestProtocol {
    typealias Response = [MovieDTO]
    
    var endpoint: String { "/core/V1/favorite/" }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
