//
//  CoreDataRecipeInformation+Fetchable.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 25.05.21.
//

import CoreData
import GenericStore

extension CoreDataRecipeInformation: Storable {
}

extension CoreDataRecipeInformation: FetchableProtocol {
    public typealias PersistenceType = NSManagedObject
    
    public typealias FetchRequest = NSFetchRequest<CoreDataRecipeInformation>
    
    public static func fetchRequest(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchRequest<CoreDataRecipeInformation> {
        let request = NSFetchRequest<CoreDataRecipeInformation>(entityName: "CoreDataRecipeInformation")
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request
    }
}
