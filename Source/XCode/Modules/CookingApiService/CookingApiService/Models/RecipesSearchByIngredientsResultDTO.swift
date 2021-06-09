//
//  RecipesSearchByIngredientsResultDTO.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 07.06.21.
//

import NetworkingService

public struct RecipesSearchByIngredientsResultDTO: DTO {

    public var id: Int
    public var title: String
    public var image: String
    public var imageType: String
    public var likes: Int
    public var missedIngredientCount: Int
    public var missedIngredients: [IngredientDTO]
    public var usedIngredientCount: Int
    public var usedIngredients: [IngredientDTO]
    public var unusedIngredients: [IngredientDTO]
    
    public var description: String {
        return """
        ------------
        id = \(id)
        ------------
        """
    }
}


