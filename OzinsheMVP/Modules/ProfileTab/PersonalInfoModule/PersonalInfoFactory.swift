import UIKit

final class PersonalInfoFactory {
    func make() -> UIViewController {
        let userProfileService = UserProfileService(networkClient: NetworkClient(host: "apiozinshe.mobydev.kz", token: Secrets.apiKey))
        
        let presenter = PersonalInfoPresenter(userProfileService: userProfileService)
        
        let vc = PersonalInfoViewController(presenter: presenter)
        
        presenter.view = vc
        return vc
    }
}
