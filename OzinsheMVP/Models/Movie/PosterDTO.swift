struct PosterDTO: Decodable {
    let fileId: Int
    let id: Int
    let link: String
    let movieId: Int
}

struct Poster {
    let link: String
}
