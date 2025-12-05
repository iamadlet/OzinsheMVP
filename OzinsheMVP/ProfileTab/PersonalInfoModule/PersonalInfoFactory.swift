import UIKit

final class PersonalInfoFactory {
    func make() -> UIViewController {
        let presenter = PersonalInfoPresenter()
        
        let vc = PersonalInfoViewController(presenter: presenter)
        
        presenter.view = vc
        return vc
    }
}
