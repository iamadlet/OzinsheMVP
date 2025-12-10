import Foundation

struct GetUserHistoryRequest: ApiRequestProtocol {
    typealias Response = [MovieDTO]
    
    var endpoint: String { "/core/V1/history/userHistory" }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
