struct GenreDTO: Decodable {
    let fileId: Int
    let id: Int
    let link: String
    let movieCount: Int?
    let name: String
}

struct Genre {
    let names: [String]
}
