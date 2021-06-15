//
//  RemoteLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 12.05.21.
//

import Foundation
import CookingApiService

public enum CookingApiServiceError: Swift.Error {
    case connectivity
    case invalidData
    case notAuthorized
}


//TODO: try with the generic RemoteLoader

public class RemoteLoader: RecipeLoader {

    private let service: CookingApiProtocol
    
    public init(service: CookingApiProtocol) {
        self.service = service
    }
    
    public func loadRecipesByTitle(_ title: String, completion: @escaping (RecipeLoader.Result) -> Void) {
        service.searchRecipesByTitle(title) { (result) in
            switch result {
            case let .success(resultDTO):
                completion(.success(resultDTO.results.map({ (dto) -> Recipe in
                    Recipe(id: dto.id, calories: dto.calories, carbs: dto.carbs, fat: dto.fat, image: dto.image, imageType: dto.imageType, protein: dto.protein, title: dto.title)
                })))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    public func loadRecipesByIngredients(_ ingredients: [String], completion: @escaping (RecipeLoader.Result) -> Void) {
        service.searchRecipesByIngredients(ingredients) { (result) in
            switch result {
            case let .success(resultDTO):
                completion(.success(resultDTO.map({ (dto) -> Recipe in
                    Recipe(id: dto.id, calories: nil, carbs: nil, fat: nil, image: dto.image, imageType: dto.imageType, protein: nil, title: dto.title)
                })))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    public func loadRecipes(predicate: NSPredicate?, completion: @escaping (RecipeLoader.Result) -> Void) {
//        if predicate != nil && predicate!.predicateFormat.contains("ingredients") {
//            let parameters = predicate!.predicateFormat.replacingOccurrences(of: "ingredients CONTAINS ", with: "")
//            service.searchRecipesByIngredients(parameters: parameters) { (result) in
//                switch result {
//                case let .success(resultDTO):
//                    completion(.success(resultDTO.map({ (dto) -> Recipe in
//                        Recipe(id: dto.id, calories: nil, carbs: nil, fat: nil, image: dto.image, imageType: dto.imageType, protein: nil, title: dto.title)
//                    })))
//                    break
//                case let .failure(error):
//                    completion(.failure(error))
//                    break
//                }
//            }
//            return
//        }
        
        if predicate != nil && !predicate!.predicateFormat.contains("title CONTAINS ") {
            completion(.failure(CookingApiServiceError.invalidData))
            return
        }
        
        service.searchRecipes(predicate: predicate) { (result) in
            switch result {
            case let .success(resultDTO):
                completion(.success(resultDTO.results.map({ (dto) -> Recipe in
                    Recipe(id: dto.id, calories: dto.calories, carbs: dto.carbs, fat: dto.fat, image: dto.image, imageType: dto.imageType, protein: dto.protein, title: dto.title)
                })))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    public func loadRecipesByNutrients(_ nutrients: NutrientParameters, completion: @escaping (RecipeLoader.Result) -> Void) {
        
        service.searchRecipesByNutrients(parameters: mapNutrientsToServiceModel(nutrients)) { (result) in
            switch result {
            case let .success(resultDTO):
                completion(.success(resultDTO.map({ (dto) -> Recipe in
                    Recipe(id: dto.id, calories: dto.calories, carbs: dto.carbs, fat: dto.fat, image: dto.image, imageType: dto.imageType, protein: dto.protein, title: dto.title)
                })))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    private func mapNutrientsToServiceModel(_ nutrients: NutrientParameters) -> CookingApiService.NutrientParameters {
        
        var numbers = [CookingApiService.NutrientParameters.NumberParameters: Int]()
        for number in nutrients.numbers {
            if let key = CookingApiService.NutrientParameters.NumberParameters(rawValue: number.key.rawValue) {
                numbers[key] = number.value
            }
        }
        
        var booleans = [CookingApiService.NutrientParameters.BooleanParameters: Bool]()
        for bool in nutrients.booleans {
            if let key = CookingApiService.NutrientParameters.BooleanParameters(rawValue: bool.key.rawValue) {
                booleans[key] = bool.value
            }
        }
            
        let parameters = CookingApiService.NutrientParameters(numbers: numbers, booleans: booleans)
        return parameters
    }
}

public class RemoteInformationLoader: RecipeInformationLoader {
    
    private let service: CookingApiProtocol
    
    public init(service: CookingApiProtocol) {
        self.service = service
    }
    public func loadRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationLoader.Result) -> Void) {
        service.getRecipeInformation(recipeId: recipeId) { (result) in
            switch result {
            case let .success(resultDTO):
                completion(.success(
                    [RecipeInformation(id: resultDTO.id,
                                       originalId: resultDTO.originalId,
                                       title: resultDTO.title,
                                       image: resultDTO.image,
                                       imageType: resultDTO.imageType,
                                       servings: resultDTO.servings,
                                       readyInMinutes: resultDTO.readyInMinutes,
                                       preparationMinutes: resultDTO.preparationMinutes,
                                       cookingMinutes: resultDTO.cookingMinutes,
                                       license: resultDTO.license,
                                       sourceName: resultDTO.sourceName,
                                       sourceUrl: resultDTO.sourceUrl,
                                       spoonacularSourceUrl: resultDTO.spoonacularSourceUrl,
                                       aggregateLikes: resultDTO.aggregateLikes,
                                       healthScore: resultDTO.healthScore,
                                       spoonacularScore: resultDTO.spoonacularScore,
                                       pricePerServing: resultDTO.pricePerServing,
                                       analyzedInstructions: [],
                                       cheap: resultDTO.cheap,
                                       creditsText: resultDTO.creditsText,
                                       cuisines: resultDTO.cuisines,
                                       dairyFree: resultDTO.dairyFree,
                                       diets: resultDTO.diets,
                                       gaps: resultDTO.gaps,
                                       glutenFree: resultDTO.glutenFree,
                                       instructions: resultDTO.instructions,
                                       ketogenic: resultDTO.ketogenic,
                                       lowFodmap: resultDTO.lowFodmap,
                                       occasions: resultDTO.occasions,
                                       sustainable: resultDTO.sustainable,
                                       vegan: resultDTO.vegan,
                                       vegetarian: resultDTO.vegetarian,
                                       veryHealthy: resultDTO.veryHealthy,
                                       veryPopular: resultDTO.veryPopular,
                                       whole30: resultDTO.whole30,
                                       weightWatcherSmartPoints: resultDTO.weightWatcherSmartPoints,
                                       dishTypes: resultDTO.dishTypes,
                                       extendedIngredients: self.mapIngredients(resultDTO.extendedIngredients),
                                       summary: resultDTO.summary,
                                       winePairing: nil)]
                ))
                break
            case let .failure(error):
                completion(.failure(error))
                break
            }
        }
    }
    
    private func mapIngredients(_ dtoIngredients: [IngredientDTO]) -> [Ingredient] {
        dtoIngredients.map { Ingredient(id: $0.id,
                                          aisle: $0.aisle,
                                          amount: $0.amount,
                                          consistency: $0.consistency,
                                          image: $0.image,
                                          measures: mapMeasures($0.measures),
                                          meta: $0.meta,
                                          metaInformation: $0.metaInformation,
                                          name: $0.name,
                                          nameClean: $0.nameClean,
                                          original: $0.original,
                                          originalName: $0.originalName,
                                          unit: $0.unit)
        }
    }
    
    private func mapMeasures(_ dtoMeasure: MeasureDTO?) -> Measure? {
        guard let dtoMeasure = dtoMeasure else { return nil }
        let localMetric = dtoMeasure.metric
        let localUs = dtoMeasure.us
        return Measure(metric: Metric(amount: localMetric.amount,
                               unitLong: localMetric.unitLong,
                               unitShort: localMetric.unitShort),
                us: Metric(amount: localUs.amount,
                           unitLong: localUs.unitLong,
                           unitShort: localUs.unitShort))
    }
}
