//
//  RecipeLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import CookingApiService

public protocol RecipeLoader {
    typealias Result = Swift.Result<[Recipe], Error>
    
    func loadRecipes(predicate: NSPredicate?, completion: @escaping (Self.Result) -> Void)
    func loadRecipesByTitle(_ title: String, completion: @escaping (Self.Result) -> Void)
    func loadRecipesByIngredients(_ ingredients: [String], completion: @escaping (Self.Result) -> Void)
    func loadRecipesByNutrients(_ nutrients: NutrientParameters, completion: @escaping (Self.Result) -> Void)
}

public protocol RecipeInformationLoader {
    typealias Result = Swift.Result<[RecipeInformation], Error>
    
    func loadRecipeInformation(recipeId: Int, completion: @escaping (Self.Result) -> Void)
}
