//
//  RecipeStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 05.05.21.
//

import GenericStore

public enum RetrieveCachedRecipesResult {
    case empty
    case found(feed: [LocalRecipe])
    case failure(Error)
}

public typealias RecipeStore = CoreDataStore<LocalRecipe>

