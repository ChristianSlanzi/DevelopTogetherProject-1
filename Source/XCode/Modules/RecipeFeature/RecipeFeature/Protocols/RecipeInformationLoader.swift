//
//  RecipeInformationLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 14.06.21.
//

public protocol RecipeInformationLoader {
    typealias Result = Swift.Result<[RecipeInformation], Error>
    
    func loadRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationLoader.Result) -> Void)
}
