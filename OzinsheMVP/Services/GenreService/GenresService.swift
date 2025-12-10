protocol GenresServiceProtocol: AnyObject {
    func fetchGenres(request: GetGenresRequest, completion: @escaping (Result<[Genre], ApiClientError>) -> Void)
}

final class GenresService: GenresServiceProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchGenres(request: GetGenresRequest, completion: @escaping (Result<[Genre], ApiClientError>) -> Void) {
        networkClient.send(request: request) { (result: Result<[GenreDTO], ApiClientError>) in
            switch result {
            case .success(let genresResponse):
                let genres = genresResponse.compactMap { Genre(response: $0) }
                completion(.success(genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
