//
//  CompositeFallbackLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 11.05.21.
//

import Foundation

public class CompositeFallbackLoader: RecipeLoader {
    
    let remote: RecipeLoader
    let local: RecipeLoader & RecipeCache
        
    public init(remote: RecipeLoader, local: RecipeLoader & RecipeCache) {
        self.remote = remote
        self.local = local
        
    }
    
    public func loadRecipesByNutrients(_ nutrients: [String: Int],  completion: @escaping (RecipeLoader.Result) -> Void) {
        remote.loadRecipesByNutrients(nutrients, completion: { [weak self] result in
            switch result {
            case let .success(data):
                print("fetch \(result) remotely")
                completion(result)
                
                self?.local.save(data) { (saveResult) in
                    switch saveResult {
                    case .success():
                        print("fetch has been cached")
                    case let .failure(error):
                        print("saving fetch failed")
                        print(error)
                    }
                }
            case .failure:
                print("remote fetch failed, fetch locally")
                
                // TODO write a predicate for the nutrients search
                let predicate: NSPredicate? = nil//NSPredicate(format: "")
                self?.retrieveLocalData(predicate: predicate, completion: { [weak self] localResult in
                    
                    guard self != nil else { return }
                    
                    switch localResult {
                    case let .success(data):
                        completion(.success(data))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                })
            }
        })
    }
    
    public func load(predicate: NSPredicate?, completion: @escaping (RecipeLoader.Result) -> Void) {
        remote.load(predicate: predicate, completion: { [weak self] result in
            switch result {
            case let .success(data):
                print("fetch \(result) remotely")
                completion(result)
                
                self?.local.save(data) { (saveResult) in
                    switch saveResult {
                    case .success():
                        print("fetch has been cached")
                    case let .failure(error):
                        print("saving fetch failed")
                        print(error)
                    }
                }
            case .failure:
                print("remote fetch failed, fetch locally")
                self?.retrieveLocalData(predicate: predicate, completion: { [weak self] localResult in
                    
                    guard self != nil else { return }
                    
                    switch localResult {
                    case let .success(data):
                        completion(.success(data))
                    case let .failure(error):
                        completion(.failure(error))
                    }
                })
            }
        })
    }
    
    private func retrieveLocalData(predicate: NSPredicate?, completion: @escaping (RecipeLoader.Result) -> Void) {
        local.load(predicate: predicate, completion: { localResult in
            switch localResult {
            case let .success(data):
                print("fetch \(data) locally")
                completion(.success(data))
            case let .failure(error):
                print("local fetch failed")
                print(error)
                completion(.failure(error))
            }
        })
    }
}
