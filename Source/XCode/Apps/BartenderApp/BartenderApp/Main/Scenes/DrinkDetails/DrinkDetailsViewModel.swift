//
//  DrinkDetailsViewModel.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation
import ImageFeature


class DrinkDetailsViewModel {
    
    var drink: Drink
    weak var view: DrinkDetailsViewProtocol?
    var placeholder: Data?

    var drinkManager: CocktailsManaging
    var imageDataLoader: ImageDataLoader
    
    init(drink: Drink, drinkManager: CocktailsManaging, imageDataLoader: ImageDataLoader) {
        self.drink = drink
        self.drinkManager = drinkManager
        self.imageDataLoader = imageDataLoader
    }
    
    func viewDidLoad() {
        
        if let placeholder = self.placeholder {
            self.view?.setDrinkImage(placeholder)
        }
        _ = imageDataLoader.loadImageData(from: URL(string: drink.strDrinkThumb)!) { result in
            switch result {
            case let .success(data):
                self.view?.setDrinkImage(data)
            case .failure(_):
               break
            }
        }
        
        view?.setDrinkTitle(drink.name)
        view?.setDrinkDescription(drink.strInstructions)
        view?.setDrinkIngredients(drink.ingredients)
        
        drinkManager.isFavorite(with: drink.idDrink) { isFavorite in
            DispatchQueue.main.async {
                self.view?.updateFavoriteStatus(isFavorite)
            }
        }
    }
    
    public func toggleFavoriteStatus() {
        drinkManager.toggleFavorite(by: drink.idDrink, completion: {
            self.drinkManager.isFavorite(with: self.drink.idDrink) { isFavorite in
                DispatchQueue.main.async {
                    self.view?.updateFavoriteStatus(isFavorite)
                }
            }
        })
    }
}
