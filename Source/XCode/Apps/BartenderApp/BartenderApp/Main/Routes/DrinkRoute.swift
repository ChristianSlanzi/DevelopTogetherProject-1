//
//  DrinkRoute.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation
import CommonRouting

protocol DrinkRoute {
    func showDrinkDetails(_ recipe: Drink)
}

extension DrinkRoute where Self: Router {

    func showDrinkDetails(_ drink: Drink, with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = BartenderAppDependencies.shared.createDrinkDetailsViewController(drink: drink)
        router.root = viewController

        route(to: viewController, as: transition)
    }

    func showDrinkDetails(_ drink: Drink) {
        showDrinkDetails(drink, with: PushTransition())
    }
}

extension DefaultRouter: DrinkRoute {}
