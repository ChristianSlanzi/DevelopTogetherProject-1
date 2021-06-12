//
//  LocalFavoriteRecipe.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 10.06.21.
//

public struct LocalFavoriteRecipe: Equatable {
    
    public var id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
