//
//  RecipeCache.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import Foundation

public protocol RecipeCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ recipes: [Recipe], completion: @escaping (RecipeCache.Result) -> Void)
}

public protocol RecipeInformationCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ recipes: [RecipeInformation], completion: @escaping (RecipeCache.Result) -> Void)
}
