import Foundation

struct GetMoviesByNameRequest: ApiRequestProtocol {
    typealias Response = [MovieDTO]
    
    var endpoint: String {
        "/core/V1/movies"
    }
    
    var parameters: [URLQueryItem]? {
        let result: [URLQueryItem] = [
            URLQueryItem(name: "name", value: term)
        ]
        return result
    }
    
    let term: String
    
    init(term: String) {
        self.term = term
    }
}
