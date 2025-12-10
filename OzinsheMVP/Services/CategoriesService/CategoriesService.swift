protocol CategoriesServiceProtocol: AnyObject {
    func fetchCategories(request: GetCategoriesRequest, completion: @escaping (Result<[Category], ApiClientError>) -> Void)
    
    func fetchCategoryAges(request: GetCategoriesAgeRequest, completion: @escaping (Result<[CategoryAge], ApiClientError>) -> Void)
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
    
    func fetchCategoryAges(request: GetCategoriesAgeRequest, completion: @escaping (Result<[CategoryAge], ApiClientError>) -> Void) {
        networkCLient.send(request: request) { (result: Result<[CategoryAgeDTO], ApiClientError>) in
            switch result {
            case .success(let categoriesAgeResponse):
                let categoriesAge = categoriesAgeResponse.compactMap { CategoryAge(response: $0) }
                completion(.success(categoriesAge))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
