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
    
    public func mapToPersistenceObject(_ object: CoreDataDrink?, context: StorageContext) -> CoreDataDrink {
        let model = object ?? CoreDataDrink(context: context as! NSManagedObjectContext)
        model.idDrink = self.idDrink
        model.strDrink = self.strDrink
        model.strDrinkThumb = self.strDrinkThumb
        model.strImageSource = self.strImageSource
        model.strIBA = self.strIBA
        model.strAlcoholic = self.strAlcoholic
        model.strGlass = self.strGlass
        model.strInstructions = self.strInstructions
        
        
        
//        let ingredients = LocalIngredients(ingredients: self.ingredients.map{ LocalIngredient(name: $0.name, measure: $0.measure) })
        
        
        //model.ingredients = nil
        //model.ingredients = NSSet.init(array: self.ingredients.map{ $0.mapToPersistenceObject(context: context) })
        model.setValue(nil, forKey: "ingredients")
        model.setValue(NSSet.init(array: self.ingredients.map{ $0.mapToPersistenceObject(nil, context: context) }), forKey: "ingredients")
    
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataDrink) -> LocalDrink {
        
//        var ingredientsArr: [LocalDrink.Ingredient] = []
//        if object.ingredients != nil {
//            let localIngredients = object.value(forKey: "ingredients") as! LocalIngredients
//            ingredientsArr = localIngredients.ingredients.map{ LocalDrink.Ingredient(name: $0.name, measure: $0.measure)}
//        }
        
        var ingredientsArr: [LocalDrink.Ingredient] = []
        if object.ingredients != nil {
            ingredientsArr = object.ingredients!.allObjects.map { LocalDrink.Ingredient.mapFromPersistenceObject($0 as! CoreDataIngredient)  }
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
