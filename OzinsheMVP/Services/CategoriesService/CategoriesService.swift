protocol CategoriesServiceProtocol: AnyObject {
    func fetchCategories(request: GetCategoriesRequest, completion: @escaping (Result<[Category], ApiClientError>) -> Void)
}

final class CategoriesService: CategoriesServiceProtocol {
    private let networkCLient: NetworkClientProtocol
    
    init(networkCLient: NetworkClientProtocol) {
        self.networkCLient = networkCLient
    }
    
    func fetchCategories(request: GetCategoriesRequest, completion: @escaping (Result<[Category], ApiClientError>) -> Void) {
        networkCLient.send(request: request) { (result: Result<[CategoryDTO], ApiClientError>) in
            switch result {
            case .success(let categoriesResponse):
                let categories = categoriesResponse.compactMap { Category(response: $0) }
                completion(.success(categories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
