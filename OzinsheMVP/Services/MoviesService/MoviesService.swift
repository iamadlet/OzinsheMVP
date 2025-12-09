protocol MoviesServiceProtocol: AnyObject {
    func fetchMovies(request: GetMoviesRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void)
}

final class MoviesService: MoviesServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchMovies(request: GetMoviesRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: Result<[MovieDTO], ApiClientError>) in
            switch result {
            case .success(let moviesResponse):
                let movies = moviesResponse.compactMap { Movie(response: $0) }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
