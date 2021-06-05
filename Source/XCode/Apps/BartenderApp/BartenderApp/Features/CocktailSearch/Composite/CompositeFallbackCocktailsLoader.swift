//
//  CompositeFallbackCocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation

public class CompositeFallbackCocktailsLoader: CocktailsLoader {

    let remote: CocktailsLoader
    let local: CocktailsLoader // & CocktailsCache
    
    public init(remote: CocktailsLoader, local: CocktailsLoader) {
        self.remote = remote
        self.local = local
    }
    
    public func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
        
        print("fetch query: \(query) remotely")
        remote.load(query: query) { (result) in
            switch result {
            case let .success(data):
                
                //TODO: save data to local persistent repository
                
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
