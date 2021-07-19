//
//  SearchViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 15.07.21.
//

import UIKit
import CommonRouting

protocol SearchViewControllerFactory {
    func makeSearchViewController() -> UIViewController
}

extension BartenderAppDependencies: SearchViewControllerFactory {
    
    func makeSearchViewController() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = SearchViewModel(router: router)
        viewModel.cocktailsLoader = makeCompositeDrinkLoader()
        let viewController = SearchViewController(viewModel: viewModel)
        router.root = viewController
        return viewController
    }
}
