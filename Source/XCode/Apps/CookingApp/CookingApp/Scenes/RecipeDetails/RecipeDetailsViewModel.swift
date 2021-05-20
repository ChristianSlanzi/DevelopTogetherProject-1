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
    weak var view: RecipeDetailsViewProtocol?
    
    init(recipe: RecipeFeature.Recipe) {
        self.recipe = recipe
    }
    
    func viewDidLoad() {
        view?.setRecipeImage(recipe.image)
        view?.setRecipeTitle(recipe.title)
        view?.setRecipeDescription(recipe.title)
    }
}
