//
//  CoreDataFavoriteDrink+Fetchable.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation
import CoreData
import GenericStore

extension CoreDataFavoriteDrink: Storable {
}

extension CoreDataFavoriteDrink: FetchableProtocol {
    public typealias PersistenceType = NSManagedObject
    
    public typealias FetchRequest = NSFetchRequest<CoreDataFavoriteDrink>
    
    public static func fetchRequest(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<CoreDataFavoriteDrink> {
        let request = NSFetchRequest<CoreDataFavoriteDrink>(entityName: "CoreDataFavoriteDrink")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
