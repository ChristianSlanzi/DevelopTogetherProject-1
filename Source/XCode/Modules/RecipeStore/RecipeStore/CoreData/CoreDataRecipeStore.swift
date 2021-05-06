//
//  CoreDataRecipeStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 05.05.21.
//

import CoreData

public final class CoreDataRecipeStore: RecipeStore {

    public init(storeURL: URL) throws {
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalRecipe], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
}
