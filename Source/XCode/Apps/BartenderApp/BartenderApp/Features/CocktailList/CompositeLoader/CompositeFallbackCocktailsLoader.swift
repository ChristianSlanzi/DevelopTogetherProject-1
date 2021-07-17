//
//  CompositeFallbackCocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation

public class CompositeFallbackCocktailsLoader: CocktailsLoader {
    
    let remote: CocktailsLoader
    let local: CocktailsLoader & CocktailsCache
    
    public init(remote: CocktailsLoader, local: CocktailsLoader & CocktailsCache) {
        self.remote = remote
        self.local = local
    }
    
    public func loadDrinksByIngredients(_ ingredients: [String], completion: @escaping (Result<[Drink], Error>) -> Void) {
        //TODO
    }
    
    public func loadAllDrinks(completion: @escaping (Result<[Drink], Error>) -> Void) {
        print("fetch all drinks remotely")
        remote.loadAllDrinks() { (result) in
            switch result {
            case let .success(data):
                //TODO: save data to local persistent repository
                self.local.save(data)  { (saveResult) in
                    switch saveResult {
                    case .success():
                        print("fetch has been cached")
                    case let .failure(error):
                        print("saving fetch failed")
                        print(error)
                    }
                }
                print("remote fetch succeded with data: \(data)")
                completion(.success(data))
                break
            case let .failure(error):
                print("remote fetch failed with error: \(error), fetch locally")
                self.local.loadAllDrinks() { (localResult) in
                    switch(localResult) {
                    case let .success(data):
                        print("local fetch succeded with data: \(data)")
                        completion(.success(data))
                    case let .failure(error):
                        print("local fetch failed with error: \(error)")
                        completion(.failure(error))
                    }
                }
                break
            }
        }
    }
    
    public func loadDrinksByFirstLetter(_ letter: Character, completion: @escaping CocktailsLoader.Result) {
        print("fetch drinks first letter: \(letter) remotely")
        remote.loadDrinksByFirstLetter(letter) { (result) in
            switch result {
            case let .success(data):
                //TODO: save data to local persistent repository
                self.local.save(data)  { (saveResult) in
                    switch saveResult {
                    case .success():
                        print("fetch has been cached")
                    case let .failure(error):
                        print("saving fetch failed")
                        print(error)
                    }
                }
                print("remote fetch succeded with data: \(data)")
                completion(.success(data))
                break
            case let .failure(error):
                print("remote fetch failed with error: \(error), fetch locally")
                self.local.loadDrinksByFirstLetter(letter) { (localResult) in
                    switch(localResult) {
                    case let .success(data):
                        print("local fetch succeded with data: \(data)")
                        completion(.success(data))
                    case let .failure(error):
                        print("local fetch failed with error: \(error)")
                        completion(.failure(error))
                    }
                }
                break
            }
        }
    }
    
    public func loadDrinks(withIds ids: [String], completion: @escaping CocktailsLoader.Result) {
        print("fetch drinks ids: \(ids.joined(separator: ",")) remotely")
        remote.loadDrinks(withIds: ids) { (result) in
            switch result {
            case let .success(data):
                
                //TODO: save data to local persistent repository
                self.local.save(data)  { (saveResult) in
                    switch saveResult {
                    case .success():
                        print("fetch has been cached")
                    case let .failure(error):
                        print("saving fetch failed")
                        print(error)
                    }
                }
                print("remote fetch succeded with data: \(data)")
                completion(.success(data))
                break
            case let .failure(error):
                print("remote fetch failed with error: \(error), fetch locally")
                self.local.loadDrinks(withIds: ids) { (localResult) in
                    switch(localResult) {
                    case let .success(data):
                        print("local fetch succeded with data: \(data)")
                        completion(.success(data))
                    case let .failure(error):
                        print("local fetch failed with error: \(error)")
                        completion(.failure(error))
                    }
                }
                break
            }
        }
    }
    
    public func load(query: String, completion: @escaping CocktailsLoader.Result) {
        self.local.load(query: query) { (localResult) in
            switch(localResult) {
            case let .success(data):
                print("local fetch succeded with data: \(data)")
                completion(.success(data))
            case let .failure(error):
                print("local fetch failed with error: \(error)")
                self.remote.load(query: query) { (result) in
                    switch result {
                    case let .success(data):
                        
                        //TODO: save data to local persistent repository
                        self.local.save(data)  { (saveResult) in
                            switch saveResult {
                            case .success():
                                print("fetch has been cached")
                            case let .failure(error):
                                print("saving fetch failed")
                                print(error)
                            }
                        }
                        print("remote fetch succeded with data: \(data)")
                        completion(.success(data))
                        break
                    case let .failure(error):
                        print("remote fetch failed with error: \(error), fetch locally")
                        self.local.load(query: query) { (localResult) in
                            switch(localResult) {
                            case let .success(data):
                                print("local fetch succeded with data: \(data)")
                                completion(.success(data))
                            case let .failure(error):
                                print("local fetch failed with error: \(error)")
                                completion(.failure(error))
                            }
                        }
                        break
                    }
                }
            }
        }
    }
    
    /*
    public func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
        
        print("fetch query: \(query) remotely")
        remote.load(query: query) { (result) in
            switch result {
            case let .success(data):
                
                //TODO: save data to local persistent repository
                self.local.save(data)  { (saveResult) in
                    switch saveResult {
                    case .success():
                        print("fetch has been cached")
                    case let .failure(error):
                        print("saving fetch failed")
                        print(error)
                    }
                }
                print("remote fetch succeded with data: \(data)")
                completion(.success(data))
                break
            case let .failure(error):
                print("remote fetch failed with error: \(error), fetch locally")
                self.local.load(query: query) { (localResult) in
                    switch(localResult) {
                    case let .success(data):
                        print("local fetch succeded with data: \(data)")
                        completion(.success(data))
                    case let .failure(error):
                        print("local fetch failed with error: \(error)")
                        completion(.failure(error))
                    }
                }
                break
            }
        }
    }*/
}
