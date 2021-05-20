//
//  NullStore.swift
//  CookingApp
//
//  Created by Christian Slanzi on 13.05.21.
//

import Foundation
import RecipeStore

class NullStore {}

extension NullStore: RecipeStore {
    func retrieve(sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    func create(_ feed: [LocalRecipe], completion: @escaping (Error?) -> Void) {
        completion(.none)
    }
    
    func deleteAll(entity: LocalRecipe.Type, completion: @escaping DeletionCompletion) {
        completion(.none)
    }
}
