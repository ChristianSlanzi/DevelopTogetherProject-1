//
//  CoreDataRecipeInformationStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 26.05.21.
//

import Foundation

import CoreData
import GenericStore

public final class CoreDataRecipeInformationStore: CoreDataStore<LocalRecipeInformation> {
    
    private static let modelName = "RecipeStore"
    
    public init(storeURL: URL) throws {
        try super.init(storeURL: storeURL, modelName: CoreDataRecipeInformationStore.modelName, in: Bundle(for: CoreDataRecipeInformationStore.self))
    }
}
