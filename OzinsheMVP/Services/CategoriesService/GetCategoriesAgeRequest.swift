import Foundation

struct GetCategoriesAgeRequest: ApiRequestProtocol {
    typealias Response = [CategoryAgeDTO]
    
    var endpoint: String {
        "/core/V1/category-ages"
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}

