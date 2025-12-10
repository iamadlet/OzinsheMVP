protocol MoviesServiceProtocol: AnyObject {
    func fetchMoviesByName(
        request: GetMoviesByNameRequest,
        completion: @escaping (Result<[Movie], ApiClientError>) -> Void
    )
    func fetchMoviesByCategoryId(
        request: GetMoviesByCategoryIdRequest,
        completion: @escaping (Result<[Movie], ApiClientError>) -> Void
    )
    func fetchMoviesForMain(
        request: GetMoviesForMainRequest,
        completion: @escaping (Result<[(categoryName: String, movies: [Movie])], ApiClientError>) -> Void
    )
}

final class MoviesService: MoviesServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchMoviesByName(request: GetMoviesByNameRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void) {
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
    
    func fetchMoviesByCategoryId(request: GetMoviesByCategoryIdRequest, completion: @escaping (Result<[Movie], ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: Result<GetMoviesByCategoryIdRequest.Response, ApiClientError>) in
            switch result {
            case .success(let response):
                let movies = response.content.compactMap { Movie(response: $0) }
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMoviesForMain(
        request: GetMoviesForMainRequest,
        completion: @escaping (Result<[(categoryName: String, movies: [Movie])], ApiClientError>) -> Void
    ) {
        networkClient.send(request: request) { (result: Result<[MoviesForMain], ApiClientError>) in
            switch result {
            case .success(let response):
                let mapped: [(String, [Movie])] = response.map { category in
                    let movies = category.movies.compactMap { Movie(response: $0) }
                    return (category.categoryName, movies)
                }
                completion(.success(mapped))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
