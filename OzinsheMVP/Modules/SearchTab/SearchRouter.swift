import UIKit

protocol SearchRouterProtocol: AnyObject {
    func openCategoryMoviesModule(source: MoviesPageSource)
}

final class SearchRouter {
    private let categoryMoviesFactory: CategoryMoviesFactory
    private weak var root: UIViewController?
    
    init(categoryMoviesFactory: CategoryMoviesFactory) {
        self.categoryMoviesFactory = categoryMoviesFactory
    }
    
    func setRootViewController(root: UIViewController) {
        self.root = root
    }
}

extension SearchRouter: SearchRouterProtocol {
    func openCategoryMoviesModule(source: MoviesPageSource) {
        print("Router openCategoryMoviesModule, root:", root as Any, "nav:", root?.navigationController as Any)
        let viewController = categoryMoviesFactory.make(with: source)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
