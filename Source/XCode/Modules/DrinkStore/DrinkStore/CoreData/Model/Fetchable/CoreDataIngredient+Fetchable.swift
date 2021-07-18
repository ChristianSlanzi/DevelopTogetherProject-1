//
//  CoreDataIngredient+Fetchable.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 17.07.21.
//

import CoreData
import GenericStore

extension CoreDataIngredient: Storable {
}

extension CoreDataIngredient: FetchableProtocol {
    public typealias PersistenceType = NSManagedObject
    
    public typealias FetchRequest = NSFetchRequest<CoreDataIngredient>
    
    public static func fetchRequest(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<CoreDataIngredient> {
        let request = NSFetchRequest<CoreDataIngredient>(entityName: "CoreDataIngredient")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
