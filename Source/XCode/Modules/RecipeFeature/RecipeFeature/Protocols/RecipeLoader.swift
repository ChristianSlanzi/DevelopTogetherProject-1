//
//  RecipeLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

public protocol RecipeLoader {
    typealias Result = Swift.Result<[Recipe], Error>
    
    func loadRecipes(predicate: NSPredicate?, completion: @escaping (RecipeLoader.Result) -> Void)
    func loadRecipesByTitle(_ title: String, completion: @escaping (RecipeLoader.Result) -> Void)
    func loadRecipesByIngredients(_ ingredients: [String], completion: @escaping (RecipeLoader.Result) -> Void)
    func loadRecipesByNutrients(_ nutrients: NutrientParameters, completion: @escaping (RecipeLoader.Result) -> Void)
}
