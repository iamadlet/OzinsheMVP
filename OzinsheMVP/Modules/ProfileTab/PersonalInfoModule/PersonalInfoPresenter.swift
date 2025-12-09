import Foundation

protocol PersonalInfoPresenterProtocol: AnyObject {
    var name: String? { get set }
    var email: String? { get set }
    var phoneNumber: String? { get set }
    var dateOfBirth: Date? { get set }
    func saveChanges()
    func loadUserProfile()
    func getUser() -> UserProfile?
}

final class PersonalInfoPresenter {
    private let userProfileService: UserProfileServiceProtocol
    weak var view: PersonalInfoViewProtocol?
    
    init(userProfileService: UserProfileServiceProtocol) {
        self.userProfileService = userProfileService
    }
    
    private var user: UserProfile?
    
    var name: String? = "Айдар"
    var email: String? = "ali@gmail.com"
    var phoneNumber: String? = "+7 702 732-10-31"
    var dateOfBirth: Date? = Calendar.current.date(from: DateComponents(year: 2004, month: 9, day: 19))
}

extension PersonalInfoPresenter: PersonalInfoPresenterProtocol {
    
    
    func saveChanges() {
        
    }
    
    func loadUserProfile() {
        let request = GetUserProfileRequest()
        
        userProfileService.fetchUserProfile(request: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let user):
                    self.user = user
                    self.view?.showUserProfile()
                case .failure(let error):
                    print("Error while loading user info: \(error)")
                    print("Localized: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getUser() -> UserProfile? {
        return user
    }
}
