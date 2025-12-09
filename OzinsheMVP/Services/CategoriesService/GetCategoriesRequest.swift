import Foundation

struct GetCategoriesRequest: ApiRequestProtocol {
    typealias Response = [CategoryDTO]
    
    var endpoint: String {
        "core/V1/categories"
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
