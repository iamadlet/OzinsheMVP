import Foundation

protocol PersonalInfoPresenterProtocol: AnyObject {
    var name: String? { get set }
    var email: String? { get set }
    var phoneNumber: String? { get set }
    var dateOfBirth: Date? { get set }
    func saveChanges()
    func loadDataFromNetwork()
}

final class PersonalInfoPresenter {
    weak var view: PersonalInfoViewProtocol?
    
    var name: String? = "Айдар"
    var email: String? = "ali@gmail.com"
    var phoneNumber: String? = "+7 702 732-10-31"
    var dateOfBirth: Date? = Calendar.current.date(from: DateComponents(year: 2004, month: 9, day: 19))
}

extension PersonalInfoPresenter: PersonalInfoPresenterProtocol {
    
    
    func saveChanges() {
        
    }
    
    func loadDataFromNetwork() {
        
    }
}
