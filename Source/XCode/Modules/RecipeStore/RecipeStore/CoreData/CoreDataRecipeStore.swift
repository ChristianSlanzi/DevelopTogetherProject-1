//
//  CoreDataRecipeStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 05.05.21.
//

import CoreData
import GenericStore

public final class CoreDataRecipeStore: CoreDataStore<LocalRecipe> {
    
    private static let modelName = "RecipeStore"
    
    public init(storeURL: URL) throws {
        try super.init(storeURL: storeURL, modelName: CoreDataRecipeStore.modelName, in: Bundle(for: CoreDataRecipeStore.self))
    }
}
