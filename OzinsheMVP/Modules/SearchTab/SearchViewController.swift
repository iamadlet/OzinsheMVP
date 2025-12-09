import UIKit

protocol SearchViewProtocol: AnyObject {
    func showCategories()
    func showLoadedMovies()
    func reloadCollectionView()
    func reloadTableView()
}

final class SearchViewController: UIViewController {
    private let presenter: SearchPresenterProtocol
    private lazy var searchView = SearchView(presenter: presenter)
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
    }
}

extension SearchViewController: SearchViewProtocol {
    func showCategories() {
        self.searchView.tableView.isHidden = true
        self.searchView.collectionView.isHidden = false
        presenter.loadCategories()
    }
    
    func showLoadedMovies() {
        self.searchView.collectionView.isHidden = true
        self.searchView.tableView.isHidden = false
        presenter.loadMovies()
    }
    
    func reloadCollectionView() {
        self.searchView.collectionView.reloadData()
    }
    
    func reloadTableView() {
        self.searchView.tableView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
