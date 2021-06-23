//
//  CollectionViewCellProtocol.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import Foundation

public protocol CollectionViewCellProtocol: AnyObject {
    func loadImage(resourceName: String)
    func setRecipeImage(_ data: Data)
    func setCaption(captionText: String)
    func setRecipeDetails(recipeDetailsText: String)
}
