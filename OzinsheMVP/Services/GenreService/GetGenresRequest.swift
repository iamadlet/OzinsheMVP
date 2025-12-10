import Foundation

struct GetGenresRequest: ApiRequestProtocol {
    typealias Response = [GenreDTO]
    
    var endpoint: String {
        "/core/V1/genres"
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
