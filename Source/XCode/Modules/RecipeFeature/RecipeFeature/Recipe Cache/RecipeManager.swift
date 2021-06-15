//
//  RecipeManager.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 10.06.21.
//

import Foundation
import RecipeStore
import GenericStore

/*
protocol RecipeManaging {
    
    // recipes
    func loadRecipesByTitle(_ title: String, completion: @escaping (RecipeLoader.Result) -> Void)
    func loadRecipesByIngredients(_ ingredients: [String], completion: @escaping (RecipeLoader.Result) -> Void)
    func loadRecipesByNutrients(_ nutrients: NutrientParameters, completion: @escaping (RecipeLoader.Result) -> Void)
    
    // recipe information
    func loadRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationLoader.Result) -> Void)
    
    // favorites ->> TODO: make a FavoriteManaging protocol and a FavoriteManager class
    func addFavorite(by recipeId: Int)
    func removeFavorite(by recipeId: Int)
    func toggleFavorite(by recipeId: Int, completion: @escaping ()->Void)
    func isFavorite(with identifier: Int, completion: @escaping (Bool)->Void)
    func getFavorites(completion: @escaping ([RecipeFeature.Recipe])->Void)
}
*/
public protocol FavoriteManaging {
    func addFavorite(by recipeId: Int)
    func removeFavorite(by recipeId: Int)
    func toggleFavorite(by recipeId: Int, completion: @escaping ()->Void)
    func isFavorite(with identifier: Int, completion: @escaping (Bool)->Void)
    func getFavorites(completion: @escaping ([RecipeFeature.Recipe])->Void)
}

public typealias RecipeManaging = RecipeLoader & RecipeInformationLoader & FavoriteManaging //& RecipeCache

public final class RecipeManager: RecipeManaging {
    
    private let recipeLoader: RecipeLoader
    private let recipeInformationLoader: RecipeInformationLoader
    private let store: FavoriteRecipeStore
    private let currentDate: () -> Date
    
    public init(store: FavoriteRecipeStore, recipeLoader: RecipeLoader, recipeInformationLoader: RecipeInformationLoader, currentDate: @escaping () -> Date) {
        self.store = store
        self.recipeLoader = recipeLoader
        self.recipeInformationLoader = recipeInformationLoader
        self.currentDate = currentDate
    }
    
    // recipes
    public func loadRecipes(predicate: NSPredicate?, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        recipeLoader.loadRecipes(predicate: predicate, completion: completion)
    }
    public func loadRecipesByTitle(_ title: String, completion: @escaping (RecipeLoader.Result) -> Void) {
        recipeLoader.loadRecipesByTitle(title, completion: completion)
    }
    
    public func loadRecipesByIngredients(_ ingredients: [String], completion: @escaping (Result<[Recipe], Error>) -> Void) {
        recipeLoader.loadRecipesByIngredients(ingredients, completion: completion)
    }
    
    public func loadRecipesByNutrients(_ nutrients: NutrientParameters, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        recipeLoader.loadRecipesByNutrients(nutrients, completion: completion)
    }
    
    
    // favorites
    
    public func addFavorite(by recipeId: Int) {
        let recipe = FavoriteRecipe(id: recipeId)
        store.create([recipe].toLocal(), completion: { (error) in
            guard let error = error else { return }
            print(error)
        })
    }
    
    public func removeFavorite(by recipeId: Int) {
        let predicate: NSPredicate = NSPredicate(format: "idCode == \(recipeId)")
        store.delete(predicate: predicate, entity: LocalFavoriteRecipe.self) { error in
            guard let error = error else { return }
            print(error)
        }
    }
    
    public func toggleFavorite(by recipeId: Int, completion: @escaping ()->Void) {
        isFavorite(with: recipeId, completion: { result in
            if result {
                print("removeFavorite")
                self.removeFavorite(by: recipeId)
                completion()
            } else {
                print("addFavorite")
                self.addFavorite(by: recipeId)
                completion()
            }
        })
    }
    
    public func isFavorite(with identifier: Int, completion: @escaping (Bool)->Void) {
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataFavoriteRecipe.idCode),
            ascending: true)
        let predicate = NSPredicate(format: "idCode == \(identifier)")
        store.retrieve(predicate: predicate, sortDescriptors: [recipeSortDescriptor]) { result in
            switch result {
            case let .failure(error):
                print(error)
                return completion(false)
            case .empty:
                return completion(false)
            case .found(feed: let feed):
                return completion(true)
            }
        }
    }
    
    public func getFavorites(completion: @escaping ([RecipeFeature.Recipe])->Void)  {
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataFavoriteRecipe.idCode),
            ascending: true)
        
        store.retrieve(predicate: nil, sortDescriptors: [recipeSortDescriptor]) { result in
            switch result {
            case let .failure(error):
                print(error)
                return completion([])
            case .empty:
                return completion([])
            case .found(feed: let feed):
            
                //TODO:
                
                var predArray = [NSPredicate]()
                for item in feed {
                    predArray.append(NSPredicate(format: "idCode == \(item.id)"))
                }

                let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predArray)
                                
                self.recipeLoader.loadRecipes(predicate: predicate) { result in
                    switch result {
                    case let .success(recipes):
                        return completion(recipes)
                    case .failure(_):
                        return completion([])
                    }
                }
            }
        }
    }
}

// RecipeInformationLoader
extension RecipeManager {
    public func loadRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationLoader.Result) -> Void) {
        recipeInformationLoader.loadRecipeInformation(recipeId: recipeId, completion: completion)
    }
}























private extension Array where Element == FavoriteRecipe {
    func toLocal() -> [LocalFavoriteRecipe] {
        return map { LocalFavoriteRecipe(id: $0.id) }
    }
}

private extension Array where Element == LocalFavoriteRecipe {
    func toModels() -> [FavoriteRecipe] {
        return map { FavoriteRecipe(id: $0.id) }
    }
}
