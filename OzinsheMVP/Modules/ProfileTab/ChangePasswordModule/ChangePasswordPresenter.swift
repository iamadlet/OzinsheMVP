import Foundation

protocol ChangePasswordPresenterProtocol: AnyObject {
    func saveChanges()
}

final class ChangePasswordPresenter {
    weak var view: ChangePasswordViewProtocol?
    
}

extension ChangePasswordPresenter: ChangePasswordPresenterProtocol {
    func saveChanges() {
        
    }
}
