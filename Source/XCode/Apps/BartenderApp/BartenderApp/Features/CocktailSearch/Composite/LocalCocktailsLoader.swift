//
//  LocalCocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import Foundation
import CocktailsApiService

class LocalCocktailsLoader: CocktailsLoader {
    func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
        
        //TODO: load cocktails from a database
        
        print("load cocktails from a database")
        
        completion(.success([Drink(idDrink: "00001", strDrink: "Margarita"),
                             Drink(idDrink: "00002", strDrink: "Long Island Ice Tea"),
                             Drink(idDrink: "00003", strDrink: "Pina Colada"),
                             Drink(idDrink: "00004", strDrink: "Whiskey Sour")]))
    }
}
