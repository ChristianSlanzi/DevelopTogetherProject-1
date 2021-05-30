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
    public var analyzedInstructions: [LocalInstruction]
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
    public var extendedIngredients: [LocalIngredient]
    public var summary: String?
    public var winePairing: LocalWinePairing?
    
    public init(id: Int, originalId: Int? = nil, title: String? = nil, image: String? = nil, imageType: String? = nil, servings: Int, readyInMinutes: Int, preparationMinutes: Int? = nil, cookingMinutes: Int? = nil, license: String? = nil, sourceName: String? = nil, sourceUrl: String? = nil, spoonacularSourceUrl: String? = nil, aggregateLikes: Int, healthScore: Float, spoonacularScore: Float, pricePerServing: Float, analyzedInstructions: [LocalInstruction], cheap: Bool, creditsText: String? = nil, cuisines: [String], dairyFree: Bool, diets: [String], gaps: String? = nil, glutenFree: Bool, instructions: String? = nil, ketogenic: Bool? = nil, lowFodmap: Bool, occasions: [String], sustainable: Bool, vegan: Bool, vegetarian: Bool, veryHealthy: Bool, veryPopular: Bool, whole30: Bool? = nil, weightWatcherSmartPoints: Int, dishTypes: [String], extendedIngredients: [LocalIngredient], summary: String? = nil, winePairing: LocalWinePairing? = nil) {
        self.id = id
        self.originalId = originalId
        self.title = title
        self.image = image
        self.imageType = imageType
        self.servings = servings
        self.readyInMinutes = readyInMinutes
        self.preparationMinutes = preparationMinutes
        self.cookingMinutes = cookingMinutes
        self.license = license
        self.sourceName = sourceName
        self.sourceUrl = sourceUrl
        self.spoonacularSourceUrl = spoonacularSourceUrl
        self.aggregateLikes = aggregateLikes
        self.healthScore = healthScore
        self.spoonacularScore = spoonacularScore
        self.pricePerServing = pricePerServing
        self.analyzedInstructions = analyzedInstructions
        self.cheap = cheap
        self.creditsText = creditsText
        self.cuisines = cuisines
        self.dairyFree = dairyFree
        self.diets = diets
        self.gaps = gaps
        self.glutenFree = glutenFree
        self.instructions = instructions
        self.ketogenic = ketogenic
        self.lowFodmap = lowFodmap
        self.occasions = occasions
        self.sustainable = sustainable
        self.vegan = vegan
        self.vegetarian = vegetarian
        self.veryHealthy = veryHealthy
        self.veryPopular = veryPopular
        self.whole30 = whole30
        self.weightWatcherSmartPoints = weightWatcherSmartPoints
        self.dishTypes = dishTypes
        self.extendedIngredients = extendedIngredients
        self.summary = summary
        self.winePairing = winePairing
    }
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

public class LocalInstruction: Equatable{
    public var name: String
    public var steps: [LocalInstructionStep]
    
    public init(name: String, steps: [LocalInstructionStep]) {
        self.name = name
        self.steps = steps
    }
    
    public static func == (lhs: LocalInstruction, rhs: LocalInstruction) -> Bool {
        return lhs.name == rhs.name // && lhs.steps == rhs.steps
    }
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


