import Foundation

struct UserProfileDTO: Decodable {
    let birthDate: String
    let id: Int
    let language: String
    let name: String
    let phoneNumber: String
    let user: UserDTO
}

struct UserDTO: Decodable {
    let email: String
    let id: Int
}


struct UserProfile {
    let name: String
    let email: String
    let phoneNumber: String
    let birthDate: String
}

extension UserProfile {
    init?(response: UserProfileDTO) {
        self.name = response.name
        self.email = response.user.email
        self.phoneNumber = response.phoneNumber
        self.birthDate = response.birthDate
    }
}
