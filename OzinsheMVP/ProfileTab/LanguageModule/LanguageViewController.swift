import UIKit

protocol LanguageViewProtocol: AnyObject {
    func didTapLanguage(_ language: String)
}

final class LanguageViewController: UIViewController {

    private let presenter: LanguagePresenterProtocol
    private lazy var languageView = LanguageView()
    private var viewTranslation = CGPoint(x: 0, y: 0)
    
    init(presenter: LanguagePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = languageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageView.langTableView.dataSource = self
        languageView.langTableView.delegate = self
    }
}

extension LanguageViewController: LanguageViewProtocol {
    func didTapLanguage(_ language: String) {
        presenter.didSelectLanguage(language)
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell") as? LanguageTableViewCell else {
            return UITableViewCell()
        }
        
        let language = presenter.language(at: indexPath.row)
        cell.configureCell(with: language)
        if presenter.getPickedLanguage() == language {
            cell.checkImage.isHidden = false
        } else {
            cell.checkImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLanguage = presenter.language(at: indexPath.row)
        presenter.didSelectLanguage(selectedLanguage)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
