import UIKit

protocol FavoritesViewProtocol: AnyObject {
    func didTapMovie()
    func showFavoriteMovies()
    func reloadTableView()
}

final class FavoritesViewController: UIViewController {
    private let presenter: FavoritesPresenterProtocol
    private lazy var favoritesView = FavoritesView(presenter: presenter)
    
    init(presenter: FavoritesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "#F9FAFB")
        navigationItem.title = "Favorites"
        favoritesView.movieTableView.dataSource = self
        favoritesView.movieTableView.delegate = self
        showFavoriteMovies()
    }
}

extension FavoritesViewController: FavoritesViewProtocol {
    func didTapMovie() {
        // TODO: Create MovieModule
    }
    
    func showFavoriteMovies() {
        presenter.loadFavorites()
    }
    
    func reloadTableView() {
        favoritesView.movieTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfFavorites()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = presenter.movie(at: indexPath.row)
        cell.configureCell(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
    
}
