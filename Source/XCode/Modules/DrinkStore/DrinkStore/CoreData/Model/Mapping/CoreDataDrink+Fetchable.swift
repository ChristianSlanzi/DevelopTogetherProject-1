//
//  CoreDataDrink+Fetchable.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import CoreData
import GenericStore

extension CoreDataDrink: Storable {
}

extension CoreDataDrink: FetchableProtocol {
    public typealias PersistenceType = NSManagedObject
    
    public typealias FetchRequest = NSFetchRequest<CoreDataDrink>
    
    public static func fetchRequest(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<CoreDataDrink> {
        let request = NSFetchRequest<CoreDataDrink>(entityName: "CoreDataDrink")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
