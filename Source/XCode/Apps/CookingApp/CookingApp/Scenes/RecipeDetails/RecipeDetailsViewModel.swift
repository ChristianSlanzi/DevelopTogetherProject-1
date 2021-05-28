//
//  RecipeDetailsViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 17.05.21.
//

import Foundation
import RecipeFeature

class RecipeDetailsViewModel {
    
    var recipe: RecipeFeature.Recipe
    var recipeInfos: RecipeFeature.RecipeInformation?
    weak var view: RecipeDetailsViewProtocol?
    public var recipeLoader: RecipeInformationLoader?
    
    init(recipe: RecipeFeature.Recipe) {
        self.recipe = recipe
    }
    
    func viewDidLoad() {
        view?.setRecipeImage(recipe.image)
        view?.setRecipeTitle(recipe.title)
        view?.setRecipeDescription(recipe.title)
        
        recipeLoader?.load(recipeId: recipe.id) { [weak self] (result) in
            print(result)
            
            guard let self = self else { return }
            
            switch result {
            case let .success(infos):
                guard let recipeInfos = infos.first(where: {$0.id == self.recipe.id}) else { return }
                self.updateRecipeInformation(recipeInfos)
            case let .failure(error):
                print(error)
            }
            
            
        }
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
            recipeInfos.extendedIngredients
        }
    }
}
