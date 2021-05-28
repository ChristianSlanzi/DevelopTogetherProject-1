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
        model.title = self.title
        model.image = self.image
        model.imageType = self.imageType
        model.servings = Int16(self.servings)
        model.readyInMinutes = Int16(self.readyInMinutes)
        if let preparationMinutes = self.preparationMinutes {
            model.preparationMinutes = Int16(preparationMinutes)
        }
        if let cookingMinutes = self.cookingMinutes {
            model.cookingMinutes = Int16(cookingMinutes)
        }
        model.license = self.license
        model.sourceName = self.sourceName
        model.sourceUrl = self.sourceUrl
        model.spoonacularSourceUrl = self.spoonacularSourceUrl
        model.aggregateLikes = Int16(self.aggregateLikes)
        model.healthScore = self.healthScore
        model.spoonacularScore = self.spoonacularScore
        model.pricePerServing = self.pricePerServing
        model.analyzedInstructions = Data() //TODO
        model.cheap = self.cheap
        model.creditsText = self.creditsText
        model.cuisines = []
        model.dairyFree = self.dairyFree
        model.diets = []
        model.gaps = self.gaps
        model.glutenFree = self.glutenFree
        model.instructions = self.instructions
        model.ketogenic = self.ketogenic ?? false
        model.lowFodmap = self.lowFodmap
        model.occasions = []
        model.sustainable = self.sustainable
        model.vegan = self.vegan
        model.vegetarian = self.vegetarian
        model.veryHealthy = self.veryHealthy
        model.veryPopular = self.veryPopular
        model.whole30 = self.whole30 ?? false
        model.weightWatcherSmartPoints = Int16(self.weightWatcherSmartPoints)
        model.dishTypes = []
        model.extendedIngredients = NSKeyedArchiver.archivedData(withRootObject: self.extendedIngredients) //Data() //TODO
        model.summary = self.summary
        model.winePairing = Data() //TODO
        
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
