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
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    func create(_ feed: [LocalRecipe], completion: @escaping (Error?) -> Void) {
        completion(.none)
    }
    
    func deleteAll(entity: LocalRecipe.Type, completion: @escaping DeletionCompletion) {
        completion(.none)
    }
}

extension NullStore: RecipeInformationStore {
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping InfoRetrievalCompletion) {
        completion(.empty)
    }
    
    func create(_ feed: [LocalRecipeInformation], completion: @escaping (Error?) -> Void) {
        completion(.none)
    }
    
    func deleteAll(entity: LocalRecipeInformation.Type, completion: @escaping InfoDeletionCompletion) {
        completion(.none)
    }
}

extension NullStore: FavoriteRecipeStore {
    func retrieve(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, completion: @escaping FavoriteRetrievalCompletion) {
        completion(.empty)
    }
    
    func create(_ feed: [LocalFavoriteRecipe], completion: @escaping (Error?) -> Void) {
        completion(.none)
    }
    
    func delete(predicate: NSPredicate?, entity: LocalFavoriteRecipe.Type, completion: @escaping FavoriteDeletionCompletion) {
        completion(.none)
    }
    
    func deleteAll(entity: LocalFavoriteRecipe.Type, completion: @escaping FavoriteDeletionCompletion) {
        completion(.none)
    }
}
