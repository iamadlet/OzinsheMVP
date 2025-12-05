import Foundation

protocol LanguagePresenterProtocol: AnyObject {
    func didSelectLanguage(_ language: String)
    func language(at index: Int) -> String
    func getPickedLanguage() -> String
}

final class LanguagePresenter {
    let languageArray = [["English", "en"], ["Қазақша", "kk"], ["Русский", "ru"]]
    
    var pickedLanguage: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.selectedLanguage) ?? "English"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.selectedLanguage)
        }
    }
    
    weak var view: LanguageViewProtocol?
}

extension LanguagePresenter: LanguagePresenterProtocol {
    func didSelectLanguage(_ language: String) {
        self.pickedLanguage = language
    }
    
    func language(at index: Int) -> String {
        languageArray[index][0]
    }
    
    func getPickedLanguage() -> String {
        pickedLanguage
    }
}
