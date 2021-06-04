//
//  MainTabBarControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import UIKit
import CommonUI

protocol MainTabBarControllerFactory {
    func makeMainTabBarController() -> MainTabBarController
}

extension BartenderAppDependencies: MainTabBarControllerFactory {
    
    func makeMainTabBarController() -> MainTabBarController {
        let tabs = [makeMainTab(), makeSearchTab(), makeFavoritesTab(), makeProfileTab()]
        let tabController = MainTabBarController(viewControllers: tabs)
        return tabController
    }
}

extension BartenderAppDependencies {
    
    func makeMainTab() -> UIViewController {
        let viewController = makeMainViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.main.item
        return navigation
    }
    
    func makeSearchTab() -> UIViewController {
        let viewController = UIViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.search.item
        return navigation
    }
    
    func makeFavoritesTab() -> UIViewController {
        let viewController = UIViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.favorites.item
        return navigation
    }
    
    func makeProfileTab() -> UIViewController {
        let viewController = UIViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.profile.item
        return navigation
    }
}

enum Tabs {
    case main
    case search
    case favorites
    case profile

    var index: Int {
        switch self {
        case .main:
            return 0
        case .search:
            return 1
        case .favorites:
            return 1
        case .profile:
            return 1
        }
    }

    var item: UITabBarItem {
        switch self {
        case .main:
            return UITabBarItem(title: "Home", image: nil, tag: index)
        case .search:
            return UITabBarItem(title: "Search", image: nil, tag: index)
        case .favorites:
            return UITabBarItem(title: "Favorites", image: nil, tag: index)
        case .profile:
            return UITabBarItem(title: "Profile", image: nil, tag: index)
        }
    }
}
