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

public typealias RetrievalCompletion = (RetrieveDataResult<LocalRecipe>) -> Void
public typealias DeletionCompletion = (Error?) -> Void

public protocol RecipeStore {
    func create(_ feed: [LocalRecipe], completion: @escaping DataStore.CreationCompletion)
    func retrieve(sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion)
    func deleteAll(entity: LocalRecipe.Type, completion: @escaping DeletionCompletion)
}
extension CoreDataRecipeStore : RecipeStore {}
