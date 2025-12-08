import UIKit

final class LanguageFactory {
    func make() -> UIViewController {
        let presenter = LanguagePresenter()
        
        let vc = LanguageViewController(presenter: presenter)
        
        presenter.view = vc
        return vc
    }
}
