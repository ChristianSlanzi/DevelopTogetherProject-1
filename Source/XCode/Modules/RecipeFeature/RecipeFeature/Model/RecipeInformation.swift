//
//  RecipeInformation.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 26.05.21.
//

import Foundation

public struct RecipeInformation: Equatable {

    public var id: Int
    public var originalId: Int?
    public var title: String?
    public var image: String?
    public var imageType: String?
    public var servings: Int
    public var readyInMinutes: Int
    public var preparationMinutes: Int?
    public var cookingMinutes: Int?
    public var license: String?
    public var sourceName: String?
    public var sourceUrl: String?
    public var spoonacularSourceUrl: String?
    public var aggregateLikes: Int
    public var healthScore: Float
    public var spoonacularScore: Float
    public var pricePerServing: Float
    public var analyzedInstructions: [Instruction]
    public var cheap: Bool
    public var creditsText: String?
    public var cuisines: [String]
    public var dairyFree: Bool
    public var diets: [String]
    public var gaps: String?
    public var glutenFree: Bool
    public var instructions: String?
    public var ketogenic: Bool?
    public var lowFodmap: Bool
    public var occasions: [String]
    public var sustainable: Bool
    public var vegan: Bool
    public var vegetarian: Bool
    public var veryHealthy: Bool
    public var veryPopular: Bool
    public var whole30: Bool?
    public var weightWatcherSmartPoints: Int
    public var dishTypes: [String]
    public var extendedIngredients: [Ingredient]
    public var summary: String?
    public var winePairing: WinePairing?
}

public struct Metric: Equatable {
    public var amount: Float
    public var unitLong: String
    public var unitShort: String
}

public struct Measure: Equatable {
    public var metric: Metric
    public var us: Metric
}

public struct Ingredient: Equatable {
    public var id: Int?
    public var aisle: String?
    public var amount: Float
    public var consistency: String?
    public var image: String?
    public var measures: Measure?
    public var meta: [String]
    public var metaInformation: [String]
    public var name: String
    public var nameClean: String?
    public var original: String
    public var originalName: String
    public var unit: String
}

public struct Product: Equatable {
    public var id: Int
    public var title: String?
    public var descr: String
    public var price: String
    public var imageUrl: String
    public var averageRating: Double
    public var ratingCount: Float
    public var score: Double
    public var link: String
}

public struct WinePairing: Equatable {
    public var pairedWines: [String]?
    public var pairingText: String?
    public var productMatches: [Product]?
}

public class Instruction: Equatable{
    public var name: String
    public var steps: [InstructionStep]
    
    public init(name: String, steps: [InstructionStep]) {
        self.name = name
        self.steps = steps
    }
    
    public static func == (lhs: Instruction, rhs: Instruction) -> Bool {
        return lhs.name == rhs.name // && lhs.steps == rhs.steps
    }
}

public struct InstructionStep: Equatable {
    public var number: Int
    public var step: String
    public var ingredients: [InstructionIngredient]
    public var equipment: [InstructionEquipment]
    public var length: InstructionLenght?
}

public struct InstructionIngredient: Equatable {
    public var id: Int
    public var name: String
    public var localizedName: String
    public var image: String
}

public struct InstructionEquipment: Equatable {
    public var id: Int
    public var name: String
    public var localizedName: String
    public var image: String
}

public struct InstructionLenght: Equatable {
    public var number: Int
    public var unit: String
}
