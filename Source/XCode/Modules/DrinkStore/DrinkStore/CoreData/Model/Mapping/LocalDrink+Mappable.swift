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
        model.strIBA = self.strIBA
        model.strAlcoholic = self.strAlcoholic
        model.strGlass = self.strGlass
        model.strInstructions = self.strInstructions
        do {
            model.ingredients = try NSKeyedArchiver.archivedData(withRootObject: self.ingredients, requiringSecureCoding: true)
        } catch {
            print("failed to archive ingredients array with error: \(error)")
        }
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataDrink) -> LocalDrink {
        var ingredientsArr: [String] = []
        if let ingredients = object.ingredients {
          do {
            if let dumpArr = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: ingredients) as? [String] {
              dump(dumpArr)
                ingredientsArr = dumpArr
            }
          } catch {
            print("could not unarchive ingredients array: \(error)")
          }
        }
        return LocalDrink(idDrink: object.idDrink ?? "",
                          strDrink: object.strDrink ?? "",
                          strDrinkThumb: object.strDrinkThumb ?? "",
                          strImageSource: object.strImageSource,
                          strInstructions: object.strInstructions ?? "",
                          ingredients: ingredientsArr,
                          strCategory: object.strCategory ?? "",
                          strIBA: object.strIBA,
                          strAlcoholic: object.strAlcoholic ?? "",
                          strGlass: object.strGlass ?? "")
    }
    
}
