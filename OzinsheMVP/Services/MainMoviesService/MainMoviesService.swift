protocol MainMoviesServiceProtocol: AnyObject {
    func fetchMainMovies(request: GetMainMoviesRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void)
}

final class MainMoviesService: MainMoviesServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchMainMovies(request: GetMainMoviesRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: Result<GetMainMoviesRequest.Response, ApiClientError>) in
            switch result {
            case .success(let response):
                let transformedMovies = response.compactMap { Movie(response: $0.movie) }
                completion(.success(transformedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
