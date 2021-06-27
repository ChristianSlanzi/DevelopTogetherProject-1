//
//  FavoritesViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 26.06.21.
//

import UIKit

protocol FavoritesViewControllerFactory {
    func makeFavoritesViewController() -> UIViewController
}

extension BartenderAppDependencies: FavoritesViewControllerFactory {
    
    func makeFavoritesViewController() -> UIViewController {
        return UIViewController()
    }
}
