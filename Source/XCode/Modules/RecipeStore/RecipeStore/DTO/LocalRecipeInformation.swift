//
//  LocalRecipeInformation.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 25.05.21.
//

import Foundation

public struct LocalRecipeInformation: Equatable {

    public var id: Int
    public var originalId: Int?
    public var title: String
    public var image: String
    public var imageType: String
    public var servings: Int
    public var readyInMinutes: Int
    public var preparationMinutes: Int?
    public var cookingMinutes: Int?
    public var license: String?
    public var sourceName: String
    public var sourceUrl: String
    public var spoonacularSourceUrl: String
    public var aggregateLikes: Int
    public var healthScore: Float
    public var spoonacularScore: Float
    public var pricePerServing: Float
    public var analyzedInstructions: [LocalInstruction]
    public var cheap: Bool
    public var creditsText: String?
    public var cuisines: [String]
    public var dairyFree: Bool
    public var diets: [String]
    public var gaps: String
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
    public var extendedIngredients: [LocalIngredient]
    public var summary: String
    public var winePairing: LocalWinePairing
}

public struct LocalMetric: Equatable {
    public var amount: Float
    public var unitLong: String
    public var unitShort: String
}

public struct LocalMeasure: Equatable {
    public var metric: LocalMetric
    public var us: LocalMetric
}

public struct LocalIngredient: Equatable {
    public var id: Int
    public var aisle: String?
    public var amount: Float
    public var consistency: String?
    public var image: String?
    public var measures: LocalMeasure
    public var meta: [String]
    public var metaInformation: [String]
    public var name: String
    public var nameClean: String?
    public var original: String
    public var originalName: String
    public var unit: String
}

public struct LocalProduct: Equatable {
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

public struct LocalWinePairing: Equatable {
    public var pairedWines: [String]?
    public var pairingText: String?
    public var productMatches: [LocalProduct]?
}

public struct LocalInstruction: Equatable{
    public var name: String
    public var steps: [LocalInstructionStep]
}

public struct LocalInstructionStep: Equatable {
    public var number: Int
    public var step: String
    public var ingredients: [LocalInstructionIngredient]
    public var equipment: [LocalInstructionEquipment]
    public var length: LocalInstructionLenght?
}

public struct LocalInstructionIngredient: Equatable {
    public var id: Int
    public var name: String
    public var localizedName: String
    public var image: String
}

public struct LocalInstructionEquipment: Equatable {
    public var id: Int
    public var name: String
    public var localizedName: String
    public var image: String
}

public struct LocalInstructionLenght: Equatable {
    public var number: Int
    public var unit: String
}


