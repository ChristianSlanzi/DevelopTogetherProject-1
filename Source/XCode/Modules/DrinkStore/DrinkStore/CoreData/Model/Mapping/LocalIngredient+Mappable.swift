//
//  LocalIngredient+Mappable.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 17.07.21.
//

import CoreData
import GenericStore

extension LocalDrink.Ingredient: Storable {}

extension LocalDrink.Ingredient: MappableProtocol {
    public func mapToPersistenceObject(_ object: CoreDataIngredient?, context: StorageContext) -> CoreDataIngredient {
        let model = object ?? CoreDataIngredient(context: context as! NSManagedObjectContext)
        model.name = self.name
        model.measure = self.measure
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataIngredient) -> LocalDrink.Ingredient {
        return LocalDrink.Ingredient(name: object.name!, measure: object.measure!)
    }
}
