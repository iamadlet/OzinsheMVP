import Foundation

protocol NetworkClientProtocol {
    var host: String { get }
    func send<T: ApiRequestProtocol>(request: T, completion: @escaping (Result<T.Response, ApiClientError>) -> Void)
}

struct NetworkClient: NetworkClientProtocol {
    let host: String
    private let token: String
    
    init(host: String, token: String) {
        self.host = host
        self.token = token
    }
    
    func send<T: ApiRequestProtocol>(request: T, completion: @escaping (Result<T.Response, ApiClientError>) -> Void) {
        guard let request = request.makeRequest(host: host) else {
            completion(.failure(ApiClientError.request))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ApiClientError.network))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiClientError.empty))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                completion(.failure(ApiClientError.service(httpResponse.statusCode)))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
                completion(.success(decodedResponse))
            } catch let DecodingError.dataCorrupted(context) {
                print("❌ JSON сломан: \(context.debugDescription)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("❌ Ключ '\(key)' не найден: \(context.debugDescription)")
                print("📂 Путь к ошибке: \(context.codingPath)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("❌ Значение '\(value)' не найдено: \(context.debugDescription)")
                print("📂 Путь к ошибке: \(context.codingPath)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("❌ Несовпадение типов '\(type)': \(context.debugDescription)")
                print("📂 Путь к ошибке: \(context.codingPath)")
            } catch {
                print("❌ Другая ошибка: \(error)")
            }
            
            guard let result = try? decoder.decode(T.Response.self, from: data) else {
                completion(.failure(ApiClientError.deserialize))
                return
            }
            
            completion(.success(result))
        }
        task.resume()
    }
}
