//
//  CoreDataRecipeInformation+CoreDataProperties.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 25.05.21.
//
//

import Foundation
import CoreData


extension CoreDataRecipeInformation {

    @NSManaged public var idCode: Int32
    @NSManaged public var originalId: Int32
    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var imageType: String?
    @NSManaged public var servings: Int16
    @NSManaged public var readyInMinutes: Int16
    @NSManaged public var preparationMinutes: Int16
    @NSManaged public var cookingMinutes: Int16
    @NSManaged public var license: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var sourceUrl: String?
    @NSManaged public var spoonacularSourceUrl: String?
    @NSManaged public var aggregateLikes: Int32
    @NSManaged public var healthScore: Float
    @NSManaged public var spoonacularScore: Float
    @NSManaged public var pricePerServing: Float
    @NSManaged public var analyzedInstructions: Data
    @NSManaged public var cheap: Bool
    @NSManaged public var creditsText: String?
    @NSManaged public var cuisines: [String]
    @NSManaged public var dairyFree: Bool
    @NSManaged public var diets: [String]
    @NSManaged public var gaps: String?
    @NSManaged public var glutenFree: Bool
    @NSManaged public var instructions: String?
    @NSManaged public var ketogenic: Bool
    @NSManaged public var lowFodmap: Bool
    @NSManaged public var occasions: [String]
    @NSManaged public var sustainable: Bool
    @NSManaged public var vegan: Bool
    @NSManaged public var vegetarian: Bool
    @NSManaged public var veryHealthy: Bool
    @NSManaged public var veryPopular: Bool
    @NSManaged public var whole30: Bool
    @NSManaged public var weightWatcherSmartPoints: Int16
    @NSManaged public var dishTypes: [String]
    @NSManaged public var extendedIngredients: Data
    @NSManaged public var summary: String?
    @NSManaged public var winePairing: Data

}

extension CoreDataRecipeInformation : Identifiable {

}

@objc(LocalInstructionValueTransformer)
final class LocalInstructionValueTransformer: NSSecureUnarchiveFromDataTransformer {

    // The name of the transformer. This is what we will use to register the transformer `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: LocalInstructionValueTransformer.self))

    // Our class `Test` should in the allowed class list. (This is what the unarchiver uses to check for the right class)
    override static var allowedTopLevelClasses: [AnyClass] {
        return [LocalInstruction.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = LocalInstructionValueTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
