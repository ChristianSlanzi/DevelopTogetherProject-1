//
//  MainTabBarControllerFactory.swift
//  CookingApp
//
//  Created by Christian Slanzi on 05.06.21.
//

import UIKit
import CommonUI
import RecipeUI

protocol MainTabBarControllerFactory {
    func makeMainTabBarController() -> MainTabBarController
}

extension CookingAppDependencies: MainTabBarControllerFactory {
    
    func makeMainTabBarController() -> MainTabBarController {
        let tabs = [makeMainTab(), makeSearchTab(), makeFavoritesTab(), makeProfileTab()]
        let tabController = MainTabBarController(viewControllers: tabs)
        return tabController
    }
}

extension CookingAppDependencies {
    func makeMainTab() -> UIViewController {
        
        var FLAG = true
        
        if FLAG {
            let router = DefaultRouter(rootTransition: EmptyTransition())
            let recipeListVC = RecipeUI_SDK.createRecipelistVC(title: "Recipes", router: router, imageLoader: makeImageDataLoader())
            router.root = recipeListVC
            recipeListVC.viewModel?.recipeLoader = makeCompositeRecipeLoader()
            
            return UINavigationController(rootViewController: recipeListVC)
        }
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = makeMainViewController(router: router)
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.main.item
        return navigation
    }
    
    func makeSearchTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = createSearchViewController(router: router)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.search.item
        return navigation
    }
    
    func makeFavoritesTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createFavoritesViewController())
        navigation.tabBarItem = Tabs.favorites.item
        return navigation
    }
    
    func makeProfileTab() -> UIViewController {
        let navigation = UINavigationController(rootViewController: createProfileViewController())
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
