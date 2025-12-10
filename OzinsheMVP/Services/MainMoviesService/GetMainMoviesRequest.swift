import Foundation

struct GetMainMoviesRequest: ApiRequestProtocol {
    typealias Response = [BannerResponse]
    
    var endpoint: String { "/core/V1/movies_main" }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}

struct BannerResponse: Decodable {
    let id: Int
    let link: String
    let fileId: Int
    let movie: MovieDTO
    let sortOrder: Int
}
