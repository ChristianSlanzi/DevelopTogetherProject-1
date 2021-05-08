//
//  LocalRecipe+CoreDataMappable.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 04.05.21.
//

import CoreData

extension LocalRecipe: MappableProtocol {
    
    public func mapToPersistenceObject(context: StorageContext) -> CoreDataRecipe {
        let model = CoreDataRecipe(context: context as! NSManagedObjectContext)
        model.idCode = Int16(self.id)
        model.calories = self.calories != nil ? (Int16(self.calories!)) : -1
        model.carbs = self.carbs
        model.fat = self.fat
        model.protein = self.protein
        model.image = self.image
        model.imageType = self.imageType
        model.title = self.title
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataRecipe) -> LocalRecipe {
        return LocalRecipe(id: Int(object.idCode), calories: Int(object.calories), carbs: object.carbs,
                           fat: object.fat, image: object.image ?? "", imageType: object.imageType ?? "",
                           protein: object.protein, title: object.title ?? "")
    }
    
}
