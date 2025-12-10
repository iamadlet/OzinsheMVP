struct CategoryDTO: Decodable {
    let fileId: Int?
    let id: Int
    let link: String?
    let movieCount: Int?
    let name: String
}

struct Category {
    let id: Int
    let name: String
}

extension Category {
    init?(response: CategoryDTO) {
        self.id = response.id
        self.name = response.name
    }
}
