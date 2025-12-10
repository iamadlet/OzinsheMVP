import UIKit

protocol TabViewRouterProtocol: AnyObject {
    func assembleTabs() -> [UIViewController]
}

final class TabViewRouter: TabViewRouterProtocol {
    private let profileFactory: ProfileFactory
    private let favoritesFactory: FavoritesFactory
    private let searchFactory: SearchFactory
    private let homeFactory: HomeFactory
    private weak var root: UIViewController?
    
    init(profileFactory: ProfileFactory, favoritesFactory: FavoritesFactory, searchFactory: SearchFactory, homeFactory: HomeFactory) {
        self.profileFactory = profileFactory
        self.favoritesFactory = favoritesFactory
        self.searchFactory = searchFactory
        self.homeFactory = homeFactory
    }
    
    func setRoot(root: UIViewController) {
        self.root = root
    }
    
    
    func assembleTabs() -> [UIViewController] {
        let profileVC = profileFactory.make()
        let profileNav = createNavController(
            root: profileVC,
            image: "Profile",
            selected: "ProfileSelected"
        )
        
        let homeVC = homeFactory.make()
        let homeNav = createNavController(
            root: homeVC,
            image: "Home",
            selected: "HomeSelected"
        )
        
        let searchVC = searchFactory.make()
        let searchNav = createNavController(
            root: searchVC,
            image: "Search",
            selected: "SearchSelected"
        )
        
        let favoritesVC = favoritesFactory.make()
        let favoritesNav = createNavController(
            root: favoritesVC,
            image: "Favorites",
            selected: "FavoritesSelected"
        )
        
        return [homeNav, searchNav, favoritesNav, profileNav]
    }
    
    private func createNavController(root: UIViewController, image: String, selected: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: image), selectedImage: UIImage(named: selected))
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return nav
    }
}
