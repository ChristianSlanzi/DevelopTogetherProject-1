//
//  CocktailsCache.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation

public protocol CocktailsCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ items: [Drink], completion: @escaping (CocktailsCache.Result) -> Void)
}
