//
//  CocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation
import CocktailsApiService

public protocol CocktailsLoader {
    typealias Result = (Swift.Result<[Drink], Error>) -> Void
    
    func loadAllDrinks(completion: @escaping CocktailsLoader.Result)
    func load(query: String, completion: @escaping CocktailsLoader.Result)
    func loadDrinks(withIds: [String], completion: @escaping CocktailsLoader.Result)
    func loadDrinksByFirstLetter(_ letter: Character, completion: @escaping CocktailsLoader.Result)
}
