//
//  LocalDrink+Mappable.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import CoreData
import GenericStore

extension LocalDrink: Storable {}

extension LocalDrink: MappableProtocol {
    
    public func mapToPersistenceObject(context: StorageContext) -> CoreDataDrink {
        let model = CoreDataDrink(context: context as! NSManagedObjectContext)
        model.idDrink = self.idDrink
        model.strDrink = self.strDrink
        model.strDrinkThumb = self.strDrinkThumb
        model.strImageSource = self.strImageSource
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataDrink) -> LocalDrink {
        return LocalDrink(idDrink: object.idDrink ?? "", strDrink: object.strDrink ?? "", strDrinkThumb: object.strDrinkThumb ?? "",
                          strImageSource: object.strImageSource, strInstructions: "TODO", ingredients: ["TODO"])
    }
    
}
