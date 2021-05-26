//
//  LocalRecipeInformation+Mappable.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 25.05.21.
//

import CoreData
import GenericStore

extension LocalRecipeInformation: Storable {}

extension LocalRecipeInformation: MappableProtocol {
    
    public func mapToPersistenceObject(context: StorageContext) -> CoreDataRecipeInformation {
        let model = CoreDataRecipeInformation(context: context as! NSManagedObjectContext)
        model.idCode = Int32(self.id)
        if let originalId = self.originalId {
            model.originalId = Int32(originalId)
        }
        
        model.image = self.image
        model.imageType = self.imageType
        model.title = self.title
        return model
    }
    
    public static func mapFromPersistenceObject(_ object: CoreDataRecipeInformation) -> LocalRecipeInformation {
        
        let analyzedInstructions: [LocalInstruction] = []
        let extendedIngredients: [LocalIngredient] = []
        let winePairing: LocalWinePairing? = nil
        
        let localRecipeInfo = LocalRecipeInformation(id: Int(object.idCode),
                                                     originalId: Int(object.originalId),
                                                     title: object.title,
                                                     image: object.image,
                                                     imageType: object.imageType,
                                                     servings: Int(object.servings),
                                                     readyInMinutes: Int(object.readyInMinutes),
                                                     preparationMinutes: Int(object.preparationMinutes),
                                                     cookingMinutes: Int(object.cookingMinutes),
                                                     license: object.license,
                                                     sourceName: object.sourceName,
                                                     sourceUrl: object.sourceUrl,
                                                     spoonacularSourceUrl: object.spoonacularSourceUrl,
                                                     aggregateLikes: Int(object.aggregateLikes),
                                                     healthScore: object.healthScore,
                                                     spoonacularScore: object.spoonacularScore,
                                                     pricePerServing: object.pricePerServing,
                                                     analyzedInstructions: [],
                                                     cheap: object.cheap,
                                                     creditsText: object.creditsText,
                                                     cuisines: [],
                                                     dairyFree: object.dairyFree,
                                                     diets: [],
                                                     gaps: object.gaps,
                                                     glutenFree: object.glutenFree,
                                                     instructions: object.instructions,
                                                     ketogenic: object.ketogenic,
                                                     lowFodmap: object.lowFodmap,
                                                     occasions: [],
                                                     sustainable: object.sustainable,
                                                     vegan: object.vegan,
                                                     vegetarian: object.vegetarian,
                                                     veryHealthy: object.veryHealthy,
                                                     veryPopular: object.veryPopular,
                                                     whole30: object.whole30,
                                                     weightWatcherSmartPoints: Int(object.weightWatcherSmartPoints),
                                                     dishTypes: [],
                                                     extendedIngredients: [],
                                                     summary: object.summary,
                                                     winePairing: nil)
        
        return localRecipeInfo
    }
    
}

class StringToDataTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        let boxedData = try! NSKeyedArchiver.archivedData(withRootObject: value!, requiringSecureCoding: true)
        return boxedData
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        let typedBlob = value as! Data
        let data = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [String.self as! AnyObject.Type], from: typedBlob)
        return (data as! String)
    }
    
}

class AttributedStringToDataTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        let boxedData = try! NSKeyedArchiver.archivedData(withRootObject: value!, requiringSecureCoding: true)
        return boxedData
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        let typedBlob = value as! Data
        let data = try! NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSAttributedString.self], from: typedBlob)
        return (data as! String)
    }
    
}
