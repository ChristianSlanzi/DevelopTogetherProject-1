//
//  LocalRecipesLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import Foundation
import RecipeStore
import GenericStore

public typealias RecipeStore = CoreDataStore<LocalRecipe>

public final class LocalRecipesLoader {
    private let store: RecipeStore
    private let currentDate: () -> Date
    
    public init(store: RecipeStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}

extension LocalRecipesLoader: RecipeLoader {
    public func load(completion: @escaping (RecipeLoader.Result) -> Void) {
        
        do {
            let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
                key: #keyPath(CoreDataRecipe.idCode),
                ascending: true)
            
            store.retrieve(sortDescriptors: [recipeSortDescriptor], completion: { (result: RetrieveDataResult<LocalRecipe>) in
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
        try store.deleteAll(entity: LocalRecipe.self, completion: { (error) in
                
        })
        try store.create(recipes.toLocal(), completion: { (error) in
            
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