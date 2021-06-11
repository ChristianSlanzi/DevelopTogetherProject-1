//
//  LocalFavoriteRecipe+Mappable.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 10.06.21.
//

import CoreData
import GenericStore

extension LocalFavoriteRecipe: Storable {}

extension LocalFavoriteRecipe: MappableProtocol {
    
    public func mapToPersistenceObject(context: StorageContext) -> CoreDataFavoriteRecipe {
        let model = CoreDataFavoriteRecipe(context: context as! NSManagedObjectContext)
        model.idCode = Int32(self.id)
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataFavoriteRecipe) -> LocalFavoriteRecipe {
        return LocalFavoriteRecipe(id: Int(object.idCode))
    }
}
