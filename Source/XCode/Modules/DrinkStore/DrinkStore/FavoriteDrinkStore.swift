//
//  FavoriteDrinkStore.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import GenericStore

public enum RetrieveCachedFavoriteResult {
    case empty
    case found(feed: [LocalFavoriteDrink])
    case failure(Error)
}

public typealias FavoriteRetrievalCompletion = (RetrieveDataResult<LocalFavoriteDrink>) -> Void
public typealias FavoriteDeletionCompletion = (Error?) -> Void

public protocol FavoriteDrinkStore {
    func create(_ feed: [LocalFavoriteDrink], completion: @escaping DataStore.CreationCompletion)
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping FavoriteRetrievalCompletion)
    func delete(predicate: NSPredicate?, entity: LocalFavoriteDrink.Type, completion: @escaping FavoriteDeletionCompletion)
    func deleteAll(entity: LocalFavoriteDrink.Type, completion: @escaping FavoriteDeletionCompletion)
}
extension CoreDataFavoriteDrinkStore : FavoriteDrinkStore {}
