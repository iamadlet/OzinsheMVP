protocol HistoryServiceProtocol: AnyObject {
    func fetchUserHistory(request: GetUserHistoryRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void)
}

final class HistoryService: HistoryServiceProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchUserHistory(request: GetUserHistoryRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: Result<GetUserHistoryRequest.Response, ApiClientError>) in
            switch result {
            case .success(let response):
                let movies = response.compactMap { Movie(response: $0) }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
