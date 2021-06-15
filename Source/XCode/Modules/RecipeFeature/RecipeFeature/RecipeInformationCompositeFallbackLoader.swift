//
//  RecipeInformationCompositeFallbackLoader.swift
//  RecipeFeature
//
//  Created by Christian Slanzi on 26.05.21.
//

import Foundation

public class RecipeInformationCompositeFallbackLoader: RecipeInformationLoader {
    
    let remote: RecipeInformationLoader
    let local: RecipeInformationLoader & RecipeInformationCache
        
    public init(remote: RecipeInformationLoader, local: RecipeInformationLoader & RecipeInformationCache) {
        self.remote = remote
        self.local = local
        
    }
    
    public func loadRecipeInformation(recipeId: Int,completion: @escaping (RecipeInformationLoader.Result) -> Void) {
        remote.loadRecipeInformation(recipeId: recipeId, completion: { [weak self] result in
            guard self != nil else { return }
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
                self?.retrieveLocalData(recipeId: recipeId, completion: { [weak self] localResult in
                    
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
    
    private func retrieveLocalData(recipeId: Int, completion: @escaping (RecipeInformationLoader.Result) -> Void) {
        local.loadRecipeInformation(recipeId: recipeId, completion: { localResult in
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
