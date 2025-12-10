import UIKit

protocol CategoryMoviesViewProtocol: AnyObject {
    func didTapMovie()
    func showMovies()
    func reloadTableView()
}

final class CategoryMoviesViewController: UIViewController {
    private let presenter: CategoryMoviePresenterProtocol
    private lazy var moviesView = CategoryMoviesView(presenter: presenter)
    
    init(presenter: CategoryMoviePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = moviesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "#F9FAFB")
        moviesView.backgroundColor = UIColor(named: "#F9FAFB")
        moviesView.movieTableView.backgroundColor = UIColor(named: "#F9FAFB")
        navigationItem.title = "Favorites"
        moviesView.movieTableView.dataSource = self
        moviesView.movieTableView.delegate = self
        showMovies()
    }
}

extension CategoryMoviesViewController: CategoryMoviesViewProtocol {
    func didTapMovie() {
        
    }
    
    func showMovies() {
        
    }
    
    func reloadTableView() {
        
    }
}

extension CategoryMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfMovies()
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
