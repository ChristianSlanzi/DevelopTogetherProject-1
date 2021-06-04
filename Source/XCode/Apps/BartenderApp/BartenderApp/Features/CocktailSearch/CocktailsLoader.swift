//
//  CocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation
import CocktailsApiService

public protocol CocktailsLoader {
    typealias Result = Swift.Result<[Drink], Error>
    
    func load(query: String, completion: @escaping (Self.Result) -> Void)
}
