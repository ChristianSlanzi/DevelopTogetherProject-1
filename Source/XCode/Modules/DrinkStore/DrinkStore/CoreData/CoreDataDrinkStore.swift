//
//  CoreDataDrinkStore.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import CoreData
import GenericStore

public final class CoreDataDrinkStore: CoreDataStore<LocalDrink> {
    
    private static let modelName = "DrinkStore"
    
    public init(storeURL: URL, managedModel: NSManagedObjectModel) throws {
        try super.init(storeURL: storeURL, modelName: CoreDataDrinkStore.modelName, managedModel: managedModel, in: Bundle(for: CoreDataDrinkStore.self))
    }
}
