import Foundation

struct CategoryAgeDTO: Decodable {
    let fileId: Int?
    let id: Int
    let link: String
    let movieCount: Int?
    let name: String
}

struct CategoryAge {
    let id: Int
    let name: String
    let link: URL?
}

extension CategoryAge {
    init?(response: CategoryAgeDTO) {
        self.id = response.id
        self.name = response.name
        let link = response.link
        let newLink = link.replacingOccurrences(of: "api.ozinshe.com", with: "apiozinshe.mobydev.kz")
        self.link = URL(string: newLink)
    }
}
