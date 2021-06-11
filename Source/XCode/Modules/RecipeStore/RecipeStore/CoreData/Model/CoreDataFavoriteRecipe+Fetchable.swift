//
//  CoreDataFavoriteRecipe+Fetchable.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 10.06.21.
//

import Foundation
import CoreData
import GenericStore

extension CoreDataFavoriteRecipe: Storable {
}

extension CoreDataFavoriteRecipe: FetchableProtocol {
    public typealias PersistenceType = NSManagedObject
    
    public typealias FetchRequest = NSFetchRequest<CoreDataFavoriteRecipe>
    
    public static func fetchRequest(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<CoreDataFavoriteRecipe> {
        let request = NSFetchRequest<CoreDataFavoriteRecipe>(entityName: "CoreDataFavoriteRecipe")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
