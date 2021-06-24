//
//  DrinkStore.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import GenericStore

public enum RetrieveCachedRecipesResult {
    case empty
    case found(feed: [LocalDrink])
    case failure(Error)
}

public typealias RetrievalCompletion = (RetrieveDataResult<LocalDrink>) -> Void
public typealias DeletionCompletion = (Error?) -> Void

public protocol DrinkStore {
    func create(_ feed: [LocalDrink], completion: @escaping DataStore.CreationCompletion)
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion)
    func deleteAll(entity: LocalDrink.Type, completion: @escaping DeletionCompletion)
}
extension CoreDataDrinkStore : DrinkStore {}
