//
//  CollectionViewCellViewModel.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import Foundation
import ImageFeature

public protocol CollectionViewCellViewModelProtocol {
    init(model: Recipe, imageDataLoader: ImageDataLoader)
    func setView(_ view: CollectionViewCellProtocol)
    func setup()
}

public class CollectionViewCellViewModel: CollectionViewCellViewModelProtocol {
    
    var recipe: Recipe
    var imageDataLoader: ImageDataLoader
    weak var collectionViewCell: CollectionViewCellProtocol?
    
    required public init(model: Recipe, imageDataLoader: ImageDataLoader) {
        self.recipe = model
        self.imageDataLoader = imageDataLoader
    }
    
    public func setView(_ view: CollectionViewCellProtocol) {
        self.collectionViewCell = view
    }
    
    public func setup() {
        guard let collectionViewCell = collectionViewCell else { return }
        
        let calories = recipe.calories != nil ? "\(recipe.calories!)" : "ND"
        
        _ = imageDataLoader.loadImageData(from: URL(string: recipe.image)!) { result in
            switch result {
            case let .success(data):
                self.collectionViewCell?.setRecipeImage(data)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
        //collectionViewCell.loadImage(resourceName: recipe.image)
        collectionViewCell.setCaption(captionText: recipe.title)
        collectionViewCell.setRecipeDetails(recipeDetailsText: calories + " kCal")
    }
}
