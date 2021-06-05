//
//  RecipeInformationResultDTO.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 24.05.21.
//

import NetworkingService

public struct MetricDTO: DTO {
    public var amount: Float
    public var unitLong: String
    public var unitShort: String
    
    public var description: String {
        return """
        ------------
        amount = \(amount)
        ------------
        """
    }
}

public struct MeasureDTO: DTO {
    public var metric: MetricDTO
    public var us: MetricDTO
    
    public var description: String {
        return """
        ------------
        metric = \(metric)
        ------------
        """
    }
}

public struct IngredientDTO: DTO {
    public var id: Int
    public var aisle: String?
    public var amount: Float
    public var consistency: String?
    public var image: String?
    public var measures: MeasureDTO
    public var meta: [String]
    public var metaInformation: [String]
    public var name: String
    public var nameClean: String?
    public var original: String
    public var originalName: String
    public var unit: String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        ------------
        """
    }
}

public struct ProductDTO: DTO {
    public var id: Int
    public var title: String?
    public var descr: String
    public var price: String
    public var imageUrl: String
    public var averageRating: Double
    public var ratingCount: Float
    public var score: Double
    public var link: String
    
    
    public var description: String {
        return """
        ------------
        id = \(id)
        ------------
        """
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case descr = "description"
        case price
        case imageUrl
        case averageRating
        case ratingCount
        case score
        case link
    }
}

public struct WinePairingDTO: DTO {
    public var pairedWines: [String]?
    public var pairingText: String?
    public var productMatches: [ProductDTO]?
    
    public var description: String {
        return """
        ------------
        pairedWines = \(pairedWines)
        ------------
        """
    }
}

public struct InstructionDTO: DTO {
    public var name: String
    public var steps: [InstructionStepDTO]
    
    public var description: String {
        return """
        ------------
        name = \(name)
        steps = \(steps)
        ------------
        """
    }
}

public struct InstructionStepDTO: DTO {
    public var number: Int
    public var step: String
    public var ingredients: [InstructionIngredientDTO]
    public var equipment: [InstructionEquipmentDTO]
    public var length: InstructionLenghtDTO?
    
    public var description: String {
        return """
        ------------
        number = \(number)
        ------------
        """
    }
}

public struct InstructionIngredientDTO: DTO {
    public var id: Int
    public var name: String
    public var localizedName: String
    public var image: String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        name = \(name)
        localizedName = \(localizedName)
        image = \(image)
        ------------
        """
    }
}

public struct InstructionEquipmentDTO: DTO {
    public var id: Int
    public var name: String
    public var localizedName: String
    public var image: String
    
    public var description: String {
        return """
        ------------
        id = \(id)
        name = \(name)
        localizedName = \(localizedName)
        image = \(image)
        ------------
        """
    }
}

public struct InstructionLenghtDTO: DTO {
    public var number: Int
    public var unit: String
    
    public var description: String {
        return """
        ------------
        number = \(number)
        unit = \(unit)
        ------------
        """
    }
}

public struct RecipeInformationResultDTO: DTO {
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
    public var analyzedInstructions: [InstructionDTO]
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
    public var extendedIngredients: [IngredientDTO]
    public var summary: String
    public var winePairing: WinePairingDTO
    public var description: String {
        return """
        ------------
        id = \(id)
        ------------
        """
    }
}
