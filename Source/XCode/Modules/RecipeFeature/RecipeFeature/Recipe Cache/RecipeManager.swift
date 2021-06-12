//
//  RecipeManager.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 10.06.21.
//

import Foundation
import RecipeStore
import GenericStore

public final class RecipeManager {
    private let recipeLoader: RecipeLoader
    private let store: FavoriteRecipeStore
    private let currentDate: () -> Date
    
    public init(store: FavoriteRecipeStore, recipeLoader: RecipeLoader, currentDate: @escaping () -> Date) {
        self.store = store
        self.recipeLoader = recipeLoader
        self.currentDate = currentDate
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
    
    public func addFavorite(by recipeId: Int) {
        let recipe = FavoriteRecipe(id: recipeId)
        store.create([recipe].toLocal(), completion: { (error) in
            guard let error = error else { return }
            print(error)
        })
    }
    
    public func removeFavorite(by recipeId: Int) {
        //let recipe = FavoriteRecipe(id: recipeId)
        let predicate: NSPredicate = NSPredicate(format: "idCode == \(recipeId)")
        //TODO delete from db
        store.delete(predicate: predicate, entity: LocalFavoriteRecipe.self) { error in
            guard let error = error else { return }
            print(error)
        }
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
                                
                self.recipeLoader.load(predicate: predicate) { result in
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
