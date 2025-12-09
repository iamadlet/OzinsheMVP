import UIKit

protocol SearchViewProtocol: AnyObject {
    func showCategories()
    func showMovies()
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
        presenter.loadCategories()
        navigationItem.title = "Search"
        
        // MARK: - Categories View
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        
        // MARK: - TextField
        searchView.searchTextField.delegate = self
        searchView.searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        searchView.onSearchButtonTapped = { [weak self] name in
            self?.presenter.loadMoviesByName(name)
        }
        searchView.onClearTapped = { [weak self] in
            guard let self = self else { return }
            if searchView.collectionView.isHidden {
                self.showCategories()
            }
        }
        
        // MARK: - Table View
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let name = textField.text, !name.isEmpty {
            presenter.loadMoviesByName(name)
            print("Searching movies by name: \(name)")
        } else {
            showCategories()
        }
    }
}

extension SearchViewController: SearchViewProtocol {
    func showCategories() {
        searchView.collectionViewHeightConstraint?.update(offset: 340)
        searchView.titleLabel.text = "Categories"
        self.searchView.tableView.isHidden = true
        self.searchView.collectionView.isHidden = false
        searchView.collectionView.reloadData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func showMovies() {
        searchView.collectionViewHeightConstraint?.update(offset: 0)
        searchView.titleLabel.text = "Search results"
        self.searchView.collectionView.isHidden = true
        self.searchView.tableView.isHidden = false
        searchView.tableView.reloadData()
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getCategoriesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let category = presenter.category(at: indexPath.item)
        cell.configureCell(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = presenter.category(at: indexPath.item)
        presenter.loadMoviesByCategoryId(category.id)
        print("Tapped category: \(category.name)")
    }
}

extension SearchViewController: UITextFieldDelegate {
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getMoviesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = presenter.movie(at: indexPath.row)
        cell.configureCell(with: movie)
        return cell
    }
}
