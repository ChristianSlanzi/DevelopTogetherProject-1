//
//  CoreDataFavoriteRecipeStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 10.06.21.
//

import CoreData
import GenericStore

public final class CoreDataFavoriteRecipeStore: CoreDataStore<LocalFavoriteRecipe> {
    
    private static let modelName = "RecipeStore"
    
    public init(storeURL: URL, managedModel: NSManagedObjectModel) throws {
        try super.init(storeURL: storeURL, modelName: CoreDataFavoriteRecipeStore.modelName, managedModel: managedModel, in: Bundle(for: CoreDataFavoriteRecipeStore.self))
    }
}
