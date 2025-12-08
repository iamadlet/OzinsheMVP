protocol FavoritesServiceProtocol: AnyObject {
    func fetchFavoriteMovies(request: GetFavoriteMoviesRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void)
}

class FavoritesService: FavoritesServiceProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchFavoriteMovies(request: GetFavoriteMoviesRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: Result<[MovieDTO], ApiClientError>) in
            switch result {
            case .success(let response):
                let transformedMovies = response.compactMap { Movie(response: $0) }
                completion(.success(transformedMovies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
