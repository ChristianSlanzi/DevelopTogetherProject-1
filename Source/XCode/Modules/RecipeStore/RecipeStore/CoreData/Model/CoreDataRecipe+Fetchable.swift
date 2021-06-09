//
//  CoreDataRecipe+Fetchable.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 08.05.21.
//

import CoreData
import GenericStore

extension CoreDataRecipe: Storable {
}

extension CoreDataRecipe: FetchableProtocol {
    public typealias PersistenceType = NSManagedObject
    
    public typealias FetchRequest = NSFetchRequest<CoreDataRecipe>
    
    public static func fetchRequest(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<CoreDataRecipe> {
        let request = NSFetchRequest<CoreDataRecipe>(entityName: "CoreDataRecipe")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
