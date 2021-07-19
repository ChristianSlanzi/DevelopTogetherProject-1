//
//  SearchRoute.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 15.07.21.
//

import Foundation
import CommonRouting

protocol SearchRoute {
    func showDrinkList(_ drinks: [Drink])
}

extension SearchRoute where Self: Router {
    func showDrinkList(_ drinks: [Drink]) {
        showDrinkList(drinks, with: PushTransition())
    }
    
    func showDrinkList(_ drinks: [Drink], with transition: Transition) {
        let dataSource = SearchDataSource(drinks: drinks)
        let viewController = BartenderAppDependencies.shared.makeMainViewController(dataSource: dataSource)
        let router = DefaultRouter(rootTransition: transition)
        router.root = viewController

        route(to: viewController, as: transition)
    }
}

extension DefaultRouter: SearchRoute {}

