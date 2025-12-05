import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func openPersonalInfoModule()
    func openChangePasswordModule()
    func openChangeLanguageModule()
    func openLogOutModule()
}

final class ProfileRouter: ProfileRouterProtocol {
    private let personalInfoFactory: PersonalInfoFactory
    private let changePasswordFactory: ChangePasswordFactory
    private let languageFactory: LanguageFactory
    private let logOutFactory: LogOutFactory
    private weak var root: UIViewController?
    
    init(personalInfoFactory: PersonalInfoFactory, languageFactory: LanguageFactory, changePasswordFactory: ChangePasswordFactory, logOutFactory: LogOutFactory) {
        self.personalInfoFactory = personalInfoFactory
        self.changePasswordFactory = changePasswordFactory
        self.languageFactory = languageFactory
        self.logOutFactory = logOutFactory
    }
    
    func setRootViewController(root: UIViewController) {
        self.root = root
    }
    
    func openPersonalInfoModule() {
        let viewController = personalInfoFactory.make()
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openChangePasswordModule() {
        let viewController = changePasswordFactory.make()
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openChangeLanguageModule() {
        let viewController = languageFactory.make()
        
        if let sheet = viewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { _ in return 303 }]
            } else {
                sheet.detents = [.medium()] // Фоллбек для старых iOS
            }
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 32
        }
        root?.present(viewController, animated: true)
    }
    
    func openLogOutModule() {
        let viewController = logOutFactory.make()
        
        if let sheet = viewController.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { _ in return 303 }]
            } else {
                sheet.detents = [.medium()] // Фоллбек для старых iOS
            }
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 32
        }
        root?.present(viewController, animated: true)
    }
}
