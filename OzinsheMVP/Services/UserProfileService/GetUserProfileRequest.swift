import Foundation

struct GetUserProfileRequest: ApiRequestProtocol {
    typealias Response = UserProfileDTO
    
    var endpoint: String { "/core/V1/user/profile" }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
}
