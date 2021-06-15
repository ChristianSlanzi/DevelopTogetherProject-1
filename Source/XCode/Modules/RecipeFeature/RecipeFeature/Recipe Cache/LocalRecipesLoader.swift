//
//  LocalRecipesLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import Foundation
import RecipeStore
import GenericStore
import CookingApiService

public final class LocalRecipesLoader {
    private let store: RecipeStore
    private let currentDate: () -> Date
    
    public init(store: RecipeStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalRecipesLoader: RecipeLoader {
    
    public func loadRecipesByTitle(_ title: String, completion: @escaping (RecipeLoader.Result) -> Void) {
        let predicate = NSPredicate(format: "title CONTAINS[c] '\(title)'")
        loadRecipes(predicate: predicate, completion: completion)
    }
    
    public func loadRecipesByIngredients(_ ingredients: [String], completion: @escaping (RecipeLoader.Result) -> Void) {
        // TODO
        let joined = ingredients.joined(separator: ",")
        let predicate = NSPredicate(format: "extendedIngredients CONTAINS[c] 'pizza'")
        loadRecipes(predicate: predicate, completion: completion)
    }
    
    public func loadRecipesByNutrients(_ nutrients: NutrientParameters, completion: @escaping (RecipeLoader.Result) -> Void) {
        // TODO
        var predicateStr = ""
        for nutrient in nutrients.numbers {
            switch nutrient.key {
            case .minCarbs:
                if !predicateStr.isEmpty { predicateStr.append(" AND ") }
                predicateStr.append("carbs.intValue >= \(nutrient.value)")
            case .maxCarbs:
                if !predicateStr.isEmpty { predicateStr.append(" AND ") }
                predicateStr.append("carbs.intValue <= \(nutrient.value)")
            case .minProtein:
                if !predicateStr.isEmpty { predicateStr.append(" AND ") }
                predicateStr.append("protein.intValue >= \(nutrient.value)")
            case .maxProtein:
                if !predicateStr.isEmpty { predicateStr.append(" AND ") }
                predicateStr.append("protein.intValue <= \(nutrient.value)")
            }
        }
        let predicate = NSPredicate(format: predicateStr)
        loadRecipes(predicate: predicate, completion: completion)
    }
    
    public func loadRecipes(predicate: NSPredicate?,  completion: @escaping (RecipeLoader.Result) -> Void) {
        
        do {
            let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
                key: #keyPath(CoreDataRecipe.idCode),
                ascending: true)
            
            store.retrieve(predicate: predicate, sortDescriptors: [recipeSortDescriptor], completion: { (result: RetrieveDataResult<LocalRecipe>) in
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

extension LocalRecipesLoader: RecipeCache {
    public func save(_ recipes: [Recipe], completion: @escaping (Result<Void, Error>) -> Void) {
//        try store.deleteAll(entity: LocalRecipe.self, completion: { (error) in
//            guard let error = error else { return }
//            print(error)
//        })
        try store.create(recipes.toLocal(), completion: { (error) in
            guard let error = error else { return }
            print(error)
        })
    }
}

private extension Array where Element == Recipe {
    func toLocal() -> [LocalRecipe] {
        return map { LocalRecipe(id: $0.id, calories: $0.calories, carbs: $0.carbs, fat: $0.fat, image: $0.image, imageType: $0.imageType, protein: $0.protein, title: $0.title) }
    }
}

private extension Array where Element == LocalRecipe {
    func toModels() -> [Recipe] {
        return map { Recipe(id: $0.id, calories: $0.calories, carbs: $0.carbs, fat: $0.fat, image: $0.image, imageType: $0.imageType, protein: $0.protein, title: $0.title) }
    }
}
