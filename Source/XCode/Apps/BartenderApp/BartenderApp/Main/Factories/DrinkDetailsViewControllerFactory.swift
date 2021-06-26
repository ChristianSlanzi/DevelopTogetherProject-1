//
//  DrinkDetailsViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import CommonUI
import UIKit

protocol DrinkDetailsViewControllerFactory {
    func makeMainViewController() -> UIViewController
}

extension BartenderAppDependencies: DrinkDetailsViewControllerFactory {

    func createDrinkDetailsViewController(drink: Drink) -> UIViewController  {
        let compositeFallbackLoader = makeCompositeDrinkLoader()
        let drinkManager = CocktailsManager(store: getFavoriteDrinkStore(), cocktailsLoader: compositeFallbackLoader) {
            Date()
        }
        let viewModel = DrinkDetailsViewModel(drink: drink, drinkManager: drinkManager, imageDataLoader: imageDataLoader)
        let viewController = DrinkDetailsViewController(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }
}

