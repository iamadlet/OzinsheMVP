import UIKit

final class ProfileFactory {
    func make() -> UIViewController {
        let router = ProfileRouter(personalInfoFactory: PersonalInfoFactory(), languageFactory: LanguageFactory(), changePasswordFactory: ChangePasswordFactory(), logOutFactory: LogOutFactory())
        
        let presenter = ProfilePresenter(router: router)
        
        let vc = ProfileViewController(presenter: presenter)
        
        presenter.view = vc
        router.setRootViewController(root: vc)
        return vc
    }
}
