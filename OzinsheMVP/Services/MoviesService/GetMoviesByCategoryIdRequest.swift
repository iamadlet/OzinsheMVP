import Foundation

struct GetMoviesByCategoryIdRequest: ApiRequestProtocol {
    typealias Response = ApiResponse
    
    var endpoint: String { "/core/V1/movies/page" }
    
    var parameters: [URLQueryItem]? {
        let result = [
            URLQueryItem(name: "categoryId", value: categoryId)
        ]
        return result
    }
    
    let categoryId: String
    
    init(categoryId: Int) {
        self.categoryId = String(categoryId)
    }
}

struct ApiResponse: Decodable {
    let content: [MovieDTO]
}
