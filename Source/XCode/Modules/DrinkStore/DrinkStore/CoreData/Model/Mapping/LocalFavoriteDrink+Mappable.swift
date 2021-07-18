//
//  LocalFavoriteDrink+Mappable.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import CoreData
import GenericStore

extension LocalFavoriteDrink: Storable {}

extension LocalFavoriteDrink: MappableProtocol {
    public func mapToPersistenceObject(_ object: CoreDataFavoriteDrink?, context: StorageContext) -> CoreDataFavoriteDrink {
        let model = object ?? CoreDataFavoriteDrink(context: context as! NSManagedObjectContext)
        model.idDrink = self.idDrink
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataFavoriteDrink) -> LocalFavoriteDrink {
        return LocalFavoriteDrink(idDrink: object.idDrink!)
    }
}
