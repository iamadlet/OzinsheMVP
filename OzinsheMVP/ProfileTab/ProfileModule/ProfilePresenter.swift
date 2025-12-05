import UIKit

protocol ProfilePresenterProtocol: AnyObject {
    var title: String { get }
    func didSelectPersonalInfo()
    func didSelectChangePassword()
    func didSelectChangeLanguage()
    func didSelectLogout()
    func didToggleThemeSwitch(isOn: Bool)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    private let router: ProfileRouterProtocol
    
    init(router: ProfileRouterProtocol) {
        self.router = router
    }
    
    var mail: String = "ali@gmail.com"
    
    var title: String {
        "Profile"
    }
    
    func didSelectPersonalInfo() {
        router.openPersonalInfoModule()
    }
    
    func didSelectChangePassword() {
        router.openChangePasswordModule()
    }
    
    func didSelectChangeLanguage() {
        router.openChangeLanguageModule()
    }
    
    func didSelectLogout() {
        router.openLogOutModule()
    }
    
    func didToggleThemeSwitch(isOn: Bool) {
        let style: UIUserInterfaceStyle = isOn ? .dark : .light
        view?.setInterfaceStyle(style)
    }
    
    
}
