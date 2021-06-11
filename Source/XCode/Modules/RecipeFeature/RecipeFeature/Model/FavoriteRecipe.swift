//
//  FavoriteRecipe.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 10.06.21.
//

import Foundation

public struct FavoriteRecipe: Equatable {
    
    public var id: Int
    
    public init(id: Int) {
        self.id = id
    }
}
