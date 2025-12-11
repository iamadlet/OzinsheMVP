import UIKit

protocol HomeRouterProtocol: AnyObject {
    func openMoviesTablePage(source: MoviesPageSource)
}

final class HomeRouter {
    private let categoryMoviesFactory: CategoryMoviesFactory
    weak var root: UIViewController?
    
    init(categoryMoviesFactory: CategoryMoviesFactory) {
        self.categoryMoviesFactory = categoryMoviesFactory
    }
    
    func setRootViewController(root: UIViewController) {
        self.root = root
    }
    
}

extension HomeRouter: HomeRouterProtocol {
    func openMoviesTablePage(source: MoviesPageSource) {
        let viewController = categoryMoviesFactory.make(with: source)
        root?.navigationController?.pushViewController(viewController, animated: true)
    }
}
