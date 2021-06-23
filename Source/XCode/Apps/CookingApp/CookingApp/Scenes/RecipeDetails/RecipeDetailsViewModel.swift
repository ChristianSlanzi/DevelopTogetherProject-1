//
//  RecipeDetailsViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 17.05.21.
//

import Foundation
import RecipeFeature
import ImageFeature

class RecipeDetailsViewModel {
    
    var recipe: RecipeFeature.Recipe
    var recipeInfos: RecipeFeature.RecipeInformation?
    weak var view: RecipeDetailsViewProtocol?

    var recipeManager: RecipeManaging
    var imageDataLoader: ImageDataLoader
    
    init(recipe: RecipeFeature.Recipe, recipeManager: RecipeManaging, imageDataLoader: ImageDataLoader) {
        self.recipe = recipe
        self.recipeManager = recipeManager
        self.imageDataLoader = imageDataLoader
    }
    
    func viewDidLoad() {
        
        //view?.setRecipeImage(recipe.image)
        _ = imageDataLoader.loadImageData(from: URL(string: recipe.image)!) { result in
            switch result {
            case let .success(data):
                self.view?.setRecipeImage(data)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
        
        view?.setRecipeTitle(recipe.title)
        view?.setRecipeDescription(recipe.title)
        
        recipeManager.isFavorite(with: recipe.id) { isFavorite in
            DispatchQueue.main.async {
                self.view?.updateFavoriteStatus(isFavorite)
            }
        }
        
        recipeManager.loadRecipeInformation(recipeId: recipe.id) { [weak self] (result) in
            print(result)
            
            guard let self = self else { return }
            
            switch result {
            case let .success(infos):
                //TODO: remove the filtering as the api should return only recipe with given id
                guard let recipeInfos = infos.first else { return }
                self.updateRecipeInformation(recipeInfos)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    public func toggleFavoriteStatus() {
        recipeManager.toggleFavorite(by: recipe.id, completion: {
            self.recipeManager.isFavorite(with: self.recipe.id) { isFavorite in
                DispatchQueue.main.async {
                    self.view?.updateFavoriteStatus(isFavorite)
                }
            }
        })
    }
    
    private func updateRecipeInformation(_ infos: RecipeInformation) {
        
        recipeInfos = infos
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let recipeInfos = self.recipeInfos else { return }
            if let summary = recipeInfos.summary {
                self.view?.setRecipeDescription(summary)
            }
            if let preparationMinutes = recipeInfos.preparationMinutes {
                self.view?.setRecipePreparationTime("Preparation\n\(preparationMinutes) minutes")
            }
            if let cookingMinutes = recipeInfos.cookingMinutes {
                self.view?.setRecipeCookingTime("Cooking\n\(cookingMinutes) minutes")
            }
            self.view?.setRecipeIngredients(recipeInfos.extendedIngredients.map { "\($0.amount) " + $0.unit + " " + $0.name })
        }
    }
}
