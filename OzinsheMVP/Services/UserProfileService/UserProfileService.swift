import Foundation

protocol UserProfileServiceProtocol: AnyObject {
    func fetchUserProfile(request: GetUserProfileRequest, completion: @escaping (Result<UserProfile, ApiClientError>) -> Void)
}

final class UserProfileService: UserProfileServiceProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchUserProfile(request: GetUserProfileRequest, completion: @escaping (Result<UserProfile, ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: (Result<UserProfileDTO, ApiClientError>)) in
            switch result {
            case .success(let userResponse):
                guard let user = UserProfile(response: userResponse) else {
                    completion(.failure(ApiClientError.deserialize))
                    return
                }
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
