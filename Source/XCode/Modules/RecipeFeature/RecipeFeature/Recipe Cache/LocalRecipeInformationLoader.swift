//
//  LocalRecipeInformationLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 26.05.21.
//

import Foundation
import RecipeStore
import GenericStore

public final class LocalRecipeInformationLoader {
    private let store: RecipeInformationStore
    private let currentDate: () -> Date
    
    public init(store: RecipeInformationStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalRecipeInformationLoader: RecipeInformationLoader {
    public func load(recipeId: Int, completion: @escaping (RecipeInformationLoader.Result) -> Void) {
        
        do {
            let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
                key: #keyPath(CoreDataRecipe.idCode),
                ascending: true)
            let predicate: NSPredicate = NSPredicate(format: "idCode == \(recipeId)")
            store.retrieve(predicate: predicate, sortDescriptors: [recipeSortDescriptor], completion: { (result: RetrieveDataResult<LocalRecipeInformation>) in
                switch result {
                case let .failure(error):
                    completion(.failure(error))
                case .empty:
                    completion(.success([]))
                case .found(feed: let feed):
                    completion(.success(feed.toModels()))
                }
            })
            
        } catch {
            completion(.failure(error))
        }
    }
}

extension LocalRecipeInformationLoader: RecipeInformationCache {
    public func save(_ recipes: [RecipeInformation], completion: @escaping (Result<Void, Error>) -> Void) {
//        try store.deleteAll(entity: LocalRecipeInformation.self, completion: { (error) in
//            print(error)
//
//        })
        store.create(recipes.toLocal(), completion: { (error) in
            guard let error = error else { return }
            print(error)
        })
    }
}

/*
private extension LocalRecipeInformation {
    init(_ recipe: RecipeInformation) {
        self.id = Int(recipe.idCode)
        ,
                  originalId: Int(recipe.originalId),
                  title: recipe.title,
                  image: recipe.image,
                  imageType: recipe.imageType,
                  servings: Int(recipe.servings),
                  readyInMinutes: Int(recipe.readyInMinutes),
                  preparationMinutes: Int(recipe.preparationMinutes),
                  cookingMinutes: Int(recipe.cookingMinutes),
                  license: recipe.license,
                  sourceName: recipe.sourceName,
                  sourceUrl: recipe.sourceUrl,
                  spoonacularSourceUrl: recipe.spoonacularSourceUrl,
                  aggregateLikes: Int(recipe.aggregateLikes),
                  healthScore: recipe.healthScore,
                  spoonacularScore: recipe.spoonacularScore,
                  pricePerServing: recipe.pricePerServing,
                  analyzedInstructions: [],
                  cheap: recipe.cheap,
                  creditsText: recipe.creditsText,
                  cuisines: [],
                  dairyFree: recipe.dairyFree,
                  diets: [],
                  gaps: recipe.gaps,
                  glutenFree: recipe.glutenFree,
                  instructions: recipe.instructions,
                  ketogenic: recipe.ketogenic,
                  lowFodmap: recipe.lowFodmap,
                  occasions: [],
                  sustainable: recipe.sustainable,
                  vegan: recipe.vegan,
                  vegetarian: recipe.vegetarian,
                  veryHealthy: recipe.veryHealthy,
                  veryPopular: recipe.veryPopular,
                  whole30: recipe.whole30,
                  weightWatcherSmartPoints: Int(recipe.weightWatcherSmartPoints),
                  dishTypes: [],
                  extendedIngredients: [],
                  summary: recipe.summary,
                  winePairing: nil)
    }
}
 */

private extension Array where Element == RecipeInformation {
    func toLocal() -> [LocalRecipeInformation] {
        return map { LocalRecipeInformation(id: Int($0.id),
                                            originalId:  nil,//$0.originalId ?? Int($0.originalId!),
                                            title: $0.title,
                                            image: $0.image,
                                            imageType: $0.imageType,
                                            servings: Int($0.servings),
                                            readyInMinutes: Int($0.readyInMinutes),
                                            preparationMinutes: nil,//$0.preparationMinutes ?? Int($0.preparationMinutes!),
                                            cookingMinutes: nil,//$0.cookingMinutes ?? Int($0.cookingMinutes!),
                                            license: $0.license,
                                            sourceName: $0.sourceName,
                                            sourceUrl: $0.sourceUrl,
                                            spoonacularSourceUrl: $0.spoonacularSourceUrl,
                                            aggregateLikes: Int($0.aggregateLikes),
                                            healthScore: $0.healthScore,
                                            spoonacularScore: $0.spoonacularScore,
                                            pricePerServing: $0.pricePerServing,
                                            analyzedInstructions: [],
                                            cheap: $0.cheap,
                                            creditsText: $0.creditsText,
                                            cuisines: [],
                                            dairyFree: $0.dairyFree,
                                            diets: [],
                                            gaps: $0.gaps,
                                            glutenFree: $0.glutenFree,
                                            instructions: $0.instructions,
                                            ketogenic: $0.ketogenic,
                                            lowFodmap: $0.lowFodmap,
                                            occasions: [],
                                            sustainable: $0.sustainable,
                                            vegan: $0.vegan,
                                            vegetarian: $0.vegetarian,
                                            veryHealthy: $0.veryHealthy,
                                            veryPopular: $0.veryPopular,
                                            whole30: $0.whole30,
                                            weightWatcherSmartPoints: Int($0.weightWatcherSmartPoints),
                                            dishTypes: [],
                                            extendedIngredients: [],
                                            summary: $0.summary,
                                            winePairing: nil) }
    }
}

private extension Array where Element == LocalRecipeInformation {
    func toModels() -> [RecipeInformation] {
        return map { RecipeInformation(id: $0.id,
                                       originalId: $0.originalId,
                                       title: $0.title,
                                       image: $0.image,
                                       imageType: $0.imageType,
                                       servings: Int($0.servings),
                                       readyInMinutes: Int($0.readyInMinutes),
                                       preparationMinutes: $0.preparationMinutes,
                                       cookingMinutes: $0.cookingMinutes,
                                       license: $0.license,
                                       sourceName: $0.sourceName,
                                       sourceUrl: $0.sourceUrl,
                                       spoonacularSourceUrl: $0.spoonacularSourceUrl,
                                       aggregateLikes: Int($0.aggregateLikes),
                                       healthScore: $0.healthScore,
                                       spoonacularScore: $0.spoonacularScore,
                                       pricePerServing: $0.pricePerServing,
                                       analyzedInstructions: [],
                                       cheap: $0.cheap,
                                       creditsText: $0.creditsText,
                                       cuisines: [],
                                       dairyFree: $0.dairyFree,
                                       diets: [],
                                       gaps: $0.gaps,
                                       glutenFree: $0.glutenFree,
                                       instructions: $0.instructions,
                                       ketogenic: $0.ketogenic,
                                       lowFodmap: $0.lowFodmap,
                                       occasions: [],
                                       sustainable: $0.sustainable,
                                       vegan: $0.vegan,
                                       vegetarian: $0.vegetarian,
                                       veryHealthy: $0.veryHealthy,
                                       veryPopular: $0.veryPopular,
                                       whole30: $0.whole30,
                                       weightWatcherSmartPoints: Int($0.weightWatcherSmartPoints),
                                       dishTypes: [],
                                       extendedIngredients: mapIngredients($0.extendedIngredients),
                                       summary: $0.summary,
                                       winePairing: nil) }
    }
    
    private func mapIngredients(_ localIngredients: [LocalIngredient]) -> [Ingredient] {
        localIngredients.map { Ingredient(id: $0.id,
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
    
    private func mapMeasures(_ localMeasure: LocalMeasure?) -> Measure? {
        guard let localMeasure = localMeasure else { return nil }
        let localMetric = localMeasure.metric
        let localUs = localMeasure.us
        return Measure(metric: Metric(amount: localMetric.amount,
                               unitLong: localMetric.unitLong,
                               unitShort: localMetric.unitShort),
                us: Metric(amount: localUs.amount,
                           unitLong: localUs.unitLong,
                           unitShort: localUs.unitShort))
    }
    
}
