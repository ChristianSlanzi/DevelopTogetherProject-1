//
//  DrinkDetailsViewControllerFactory.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import CommonUI
import UIKit

protocol DrinkDetailsViewControllerFactory {
    func createDrinkDetailsViewController(drink: Drink) -> UIViewController
}

extension BartenderAppDependencies: DrinkDetailsViewControllerFactory {

    func createDrinkDetailsViewController(drink: Drink) -> UIViewController  {
        
        let viewModel = DrinkDetailsViewModel(drink: drink, drinkManager: getDrinkManager(), imageDataLoader: imageDataLoader)
        viewModel.placeholder = UIImage(named: "drink-placeholder")?.pngData()
        let viewController = DrinkDetailsViewController(viewModel: viewModel)
        viewModel.view = viewController
        return viewController
    }
}

