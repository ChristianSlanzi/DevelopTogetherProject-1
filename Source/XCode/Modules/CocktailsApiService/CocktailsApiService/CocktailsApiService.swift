//
//  CocktailsApiService.swift
//  CocktailsApiService
//
//  Created by Christian Slanzi on 03.06.21.
//

import NetworkingService

public protocol CocktailsApiService {
    //Search cocktail by name
    func searchCocktailByName(_ name: String)
    func searchCocktailsByFirstLetter(_ letter: Character)
}
