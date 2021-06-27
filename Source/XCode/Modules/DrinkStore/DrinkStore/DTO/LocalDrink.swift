//
//  LocalDrink.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation

public struct LocalDrink: Equatable {
    
    public var idDrink: String
    public var strDrink: String
    public var strDrinkThumb: String
    public var strImageSource: String?
    public var strInstructions: String
    public var ingredients: [String]
    
    public init(idDrink: String, strDrink: String, strDrinkThumb: String, strImageSource: String? = nil, strInstructions: String, ingredients: [String]) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        self.strImageSource = strImageSource
        self.strInstructions = strInstructions
        self.ingredients = ingredients
    }
}
