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

    var imageDataLoader: ImageDataLoader
    
    init(drink: Drink, imageDataLoader: ImageDataLoader) {
        self.drink = drink
        self.imageDataLoader = imageDataLoader
    }
    
    func viewDidLoad() {
        
        //view?.setRecipeImage(recipe.image)
        _ = imageDataLoader.loadImageData(from: URL(string: drink.strDrinkThumb)!) { result in
            switch result {
            case let .success(data):
                self.view?.setDrinkImage(data)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
        
        view?.setDrinkTitle(drink.name)
        view?.setDrinkDescription(drink.name)
        
//        drinkManager.isFavorite(with: drink.id) { isFavorite in
//            DispatchQueue.main.async {
//                self.view?.updateFavoriteStatus(isFavorite)
//            }
//        }
    }
    
    public func toggleFavoriteStatus() {
//        drinkManager.toggleFavorite(by: drink.id, completion: {
//            self.recipeManager.isFavorite(with: self.recipe.id) { isFavorite in
//                DispatchQueue.main.async {
//                    self.view?.updateFavoriteStatus(isFavorite)
//                }
//            }
//        })
    }
}
