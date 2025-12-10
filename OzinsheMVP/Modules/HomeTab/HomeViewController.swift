import UIKit
import SnapKit

protocol HomeViewProtocol: AnyObject {
    func showBanner()
    func showHistory()
    func showCategoryAges()
    func showGenres()
    func showMovies()
}

final class HomeViewController: UIViewController {
    private let presenter: HomePresenterProtocol
    private lazy var homeView = HomeView(presenter: presenter)
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        
        homeView.tableView.register(BannerSectionCell.self, forCellReuseIdentifier: BannerSectionCell.identifier)
        homeView.tableView.register(ContinueWatchingSectionCell.self, forCellReuseIdentifier: ContinueWatchingSectionCell.identifier)
        homeView.tableView.register(CategoryAgeSectionCell.self, forCellReuseIdentifier: CategoryAgeSectionCell.identifier)
        homeView.tableView.register(GenreSectionCell.self, forCellReuseIdentifier: GenreSectionCell.identifier)
        homeView.tableView.register(MoviesSectionCell.self, forCellReuseIdentifier: MoviesSectionCell.identifier)
        
        presenter.loadMainMovies()
        presenter.loadHistory()
        presenter.loadCategoryAges()
        presenter.loadGenres()
        presenter.loadMainCategories()
    }
}

extension HomeViewController: HomeViewProtocol {
    func showBanner() {
        print("🔵 showBanner() called")
        homeView.tableView.reloadData()
    }
    
    func showHistory() {
        print("🟡 showHistory() called")
        homeView.tableView.reloadData()
    }
    
    func showCategoryAges() {
        homeView.tableView.reloadData()
    }
    
    func showGenres() {
        homeView.tableView.reloadData()
    }
    
    func showMovies() {
        homeView.tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = presenter.section(at: indexPath.section)
        
        switch section {
        case .banner:
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerSectionCell.identifier, for: indexPath) as! BannerSectionCell
            cell.configure(presenter: presenter, sectionIndex: indexPath.section)
            return cell
        case .continueWatching:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContinueWatchingSectionCell.identifier, for: indexPath) as! ContinueWatchingSectionCell
            cell.configure(presenter: presenter, sectionIndex: indexPath.section)
            return cell
        case .ageCategories:
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryAgeSectionCell.identifier, for: indexPath) as! CategoryAgeSectionCell
            cell.configure(presenter: presenter, sectionIndex: indexPath.section)
            return cell
        case .genres:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenreSectionCell.identifier, for: indexPath) as! GenreSectionCell
            cell.configure(presenter: presenter, sectionIndex: indexPath.section)
            return cell
        case .categoryMovies:
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesSectionCell.identifier, for: indexPath) as! MoviesSectionCell
            cell.configure(presenter: presenter, sectionIndex: indexPath.section)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = presenter.section(at: indexPath.section)
        
        switch section {
        case .banner:
            return 280
        case .continueWatching:
            return 196
        case .ageCategories:
            return 152
        case .genres:
            return 152
        default:
            return 260
        }
    }
    
    // TODO: - В БУДУЩЕМ ЗАМЕНИТЬ НА КЛАСС HeaderView(title + button)
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = presenter.section(at: section)
        
        guard let title = sectionModel.title else { return nil }
        
        let label = UILabel()
        label.text = title
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "#111827")
        
        let container = UIView()
        container.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview()
        }
        
        return container
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        presenter.section(at: section).title == nil ? 0 : 24
    }
}
