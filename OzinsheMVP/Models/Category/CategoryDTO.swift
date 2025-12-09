struct CategoryDTO: Decodable {
    let fileId: Int
    let id: Int
    let link: String
    let movieLing: String
    let name: String
}

struct Category {
    let name: String
}

extension Category {
    init?(response: CategoryDTO) {
        self.name = response.name
    }
}
