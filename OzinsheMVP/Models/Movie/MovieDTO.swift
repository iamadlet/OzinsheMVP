import Foundation

struct MovieDTO: Decodable {
    let createdDate: String
    let description: String
    let director: String
    let favorite: Bool
    let genres: [GenreDTO]
    let id: Int
    let keyWords: String
    let lastModifiedDate: String
    let movieType: MovieType
    let name: String
    let poster: PosterDTO
    let producer: String
    let screenshots: [ScreenshotDTO]
    let seasonCount: Int
    let seriesCount: Int
    let timing: Int
    let trend: Bool
    let video: VideoDTO?
    let watchCount: Int
    let year: Int
}

struct Movie {
    let id: Int
    let name: String
    let posterLink: String
    let yearText: String
    
    // TODO: - Change GenreDTO to Genre Model
    let genres: [String]
    let posterURL: URL?
}

extension Movie {
    init?(response: MovieDTO) {
        self.id = response.id
        self.name = response.name
        self.posterLink = response.poster.link
        self.yearText = String(response.year)
        
        let domainGenres = response.genres.compactMap { $0.name }
        self.genres = domainGenres
        
        let oldLinkString = response.poster.link
        let newLinkURL = oldLinkString.replacingOccurrences(of: "api.ozinshe.com", with: "apiozinshe.mobydev.kz")
        self.posterURL = URL(string: newLinkURL)
    }
}
