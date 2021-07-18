//
//  NullStore.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation
import DrinkStore

class NullStore {}

extension NullStore: DrinkStore {
    func create(_ feed: [LocalDrink], completion: @escaping (Error?) -> Void) {
        completion(.none)
    }
    
    func update(_ item: LocalDrink, predicate: NSPredicate?, completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    func deleteAll(entity: LocalDrink.Type, completion: @escaping DeletionCompletion) {
        completion(.none)
    }
}

extension NullStore: FavoriteDrinkStore {
    func create(_ feed: [LocalFavoriteDrink], completion: @escaping (Error?) -> Void) {
        completion(.none)
    }
    
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping FavoriteRetrievalCompletion) {
        completion(.empty)
    }
    
    func delete(predicate: NSPredicate?, entity: LocalFavoriteDrink.Type, completion: @escaping FavoriteDeletionCompletion) {
        completion(.none)
    }
    
    func deleteAll(entity: LocalFavoriteDrink.Type, completion: @escaping FavoriteDeletionCompletion) {
        completion(.none)
    }
}
