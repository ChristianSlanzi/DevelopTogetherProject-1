//
//  CocktailsManager.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation
import DrinkStore
import GenericStore

public protocol FavoriteManaging {
    func addFavorite(by identifier: String)
    func removeFavorite(by identifier: String)
    func toggleFavorite(by identifier: String, completion: @escaping ()->Void)
    func isFavorite(with identifier: String, completion: @escaping (Bool)->Void)
    func getFavorites(completion: @escaping ([Drink])->Void)
}

public typealias CocktailsManaging = CocktailsLoader & FavoriteManaging //& DrinkCache

public final class CocktailsManager: CocktailsManaging {
    private let cocktailsLoader: CocktailsLoader
    private let store: FavoriteDrinkStore
    private let currentDate: () -> Date
    
    public init(store: FavoriteDrinkStore,
                cocktailsLoader: CocktailsLoader,
                currentDate: @escaping () -> Date) {
        self.store = store
        self.cocktailsLoader = cocktailsLoader
        self.currentDate = currentDate
    }
    
    // drinks
    
    public func loadDrinksByIngredients(_ ingredients: [String], completion: @escaping CocktailsLoader.Result) {
        cocktailsLoader.loadDrinksByIngredients(ingredients, completion: completion)
    }
    
    public func loadAllDrinks(completion: @escaping (Result<[Drink], Error>) -> Void) {
        cocktailsLoader.loadAllDrinks(completion: completion)
    }
    public func loadDrinksByFirstLetter(_ letter: Character, completion: @escaping CocktailsLoader.Result) {
        cocktailsLoader.loadDrinksByFirstLetter(letter, completion: completion)
    }
    
    public func loadDrinks(withIds ids: [String], completion: @escaping CocktailsLoader.Result) {
        cocktailsLoader.loadDrinks(withIds: ids, completion: completion)
    }
    public func load(query: String, completion: @escaping CocktailsLoader.Result) {
        cocktailsLoader.load(query: query, completion: completion)
    }
    
    
    
    // favorites
    
    public func addFavorite(by idDrink: String) {
        let recipe = FavoriteDrink(idDrink: idDrink)
        store.create([recipe].toLocal(), completion: { (error) in
            guard let error = error else { return }
            print(error)
        })
    }
    
    public func removeFavorite(by identifier: String) {
        let predicate: NSPredicate = NSPredicate(format: "idDrink == \(identifier)")
        store.delete(predicate: predicate, entity: LocalFavoriteDrink.self) { error in
            guard let error = error else { return }
            print(error)
        }
    }
    
    public func toggleFavorite(by identifier: String, completion: @escaping ()->Void) {
        isFavorite(with: identifier, completion: { result in
            if result {
                print("removeFavorite")
                self.removeFavorite(by: identifier)
                completion()
            } else {
                print("addFavorite")
                self.addFavorite(by: identifier)
                completion()
            }
        })
    }
    
    public func isFavorite(with identifier: String, completion: @escaping (Bool)->Void) {
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataFavoriteDrink.idDrink),
            ascending: true)
        let predicate = NSPredicate(format: "idDrink == \(identifier)")
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
    
    public func getFavorites(completion: @escaping ([Drink])->Void)  {
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataFavoriteDrink.idDrink),
            ascending: true)
        
        store.retrieve(predicate: nil, sortDescriptors: [recipeSortDescriptor]) { result in
            switch result {
            case let .failure(error):
                print(error)
                return completion([])
            case .empty:
                return completion([])
            case .found(feed: let feed):
                self.cocktailsLoader.loadDrinks(withIds: feed.compactMap({ $0.idDrink})) { result in
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

private extension Array where Element == FavoriteDrink {
    func toLocal() -> [LocalFavoriteDrink] {
        return map { LocalFavoriteDrink(idDrink: $0.idDrink) }
    }
}

private extension Array where Element == LocalFavoriteDrink {
    func toModels() -> [FavoriteDrink] {
        return map { FavoriteDrink(idDrink: $0.idDrink) }
    }
}
