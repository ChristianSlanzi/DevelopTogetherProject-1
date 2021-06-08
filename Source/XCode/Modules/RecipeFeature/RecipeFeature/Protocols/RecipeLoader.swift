//
//  RecipeLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import Foundation

public protocol RecipeLoader {
    typealias Result = Swift.Result<[Recipe], Error>
    
    func load(predicate: NSPredicate?,  completion: @escaping (Self.Result) -> Void)
    func loadRecipesByNutrients(_ nutrients: [String: Int],  completion: @escaping (Self.Result) -> Void)
}

public protocol RecipeInformationLoader {
    typealias Result = Swift.Result<[RecipeInformation], Error>
    
    func load(recipeId: Int, completion: @escaping (Self.Result) -> Void)
}
