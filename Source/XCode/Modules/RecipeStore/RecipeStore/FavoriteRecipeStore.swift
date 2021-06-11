//
//  FavoriteStore.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 10.06.21.
//

import GenericStore

public enum RetrieveCachedFavoriteResult {
    case empty
    case found(feed: [LocalFavoriteRecipe])
    case failure(Error)
}

public typealias FavoriteRetrievalCompletion = (RetrieveDataResult<LocalFavoriteRecipe>) -> Void
public typealias FavoriteDeletionCompletion = (Error?) -> Void

public protocol FavoriteRecipeStore {
    func create(_ feed: [LocalFavoriteRecipe], completion: @escaping DataStore.CreationCompletion)
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping FavoriteRetrievalCompletion)
    func delete(predicate: NSPredicate?, entity: LocalFavoriteRecipe.Type, completion: @escaping FavoriteDeletionCompletion)
    func deleteAll(entity: LocalFavoriteRecipe.Type, completion: @escaping FavoriteDeletionCompletion)
}
extension CoreDataFavoriteRecipeStore : FavoriteRecipeStore {}
