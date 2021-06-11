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
    
    public init(storeURL: URL, managedModel: NSManagedObjectModel) throws {
        try super.init(storeURL: storeURL, modelName: CoreDataRecipeStore.modelName, managedModel: managedModel, in: Bundle(for: CoreDataRecipeStore.self))
    }
}
