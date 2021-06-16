//
//  CollectionViewCellViewModel.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import Foundation

public protocol CollectionViewCellViewModelProtocol {
    init(model: Recipe)
    func setView(_ view: CollectionViewCellProtocol)
    func setup()
}

public class CollectionViewCellViewModel: CollectionViewCellViewModelProtocol {
    
    var recipe: Recipe
    weak var collectionViewCell: CollectionViewCellProtocol?
    
    required public init(model: Recipe) {
        self.recipe = model
    }
    
    public func setView(_ view: CollectionViewCellProtocol) {
        self.collectionViewCell = view
    }
    
    public func setup() {
        guard let collectionViewCell = collectionViewCell else { return }
        
        let calories = recipe.calories != nil ? "\(recipe.calories!)" : "ND"
        collectionViewCell.loadImage(resourceName: recipe.image)
        collectionViewCell.setCaption(captionText: recipe.title)
        collectionViewCell.setRecipeDetails(recipeDetailsText: calories + " kCal")
    }
}
