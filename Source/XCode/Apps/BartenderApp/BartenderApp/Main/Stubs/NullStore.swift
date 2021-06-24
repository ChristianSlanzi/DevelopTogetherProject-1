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
    
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    func deleteAll(entity: LocalDrink.Type, completion: @escaping DeletionCompletion) {
        completion(.none)
    }
}
