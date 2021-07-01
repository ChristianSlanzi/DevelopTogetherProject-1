//
//  LocalDrink.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 24.06.21.
//

import Foundation

public struct LocalDrink: Equatable {
    
    public struct Ingredient: Equatable {
        
        public var name: String
        public var measure: String
        
        public init(name: String, measure: String) {
            self.name = name
            self.measure = measure
        }
    }
    
    public var idDrink: String
    public var strDrink: String
    public var strDrinkThumb: String
    public var strImageSource: String?
    public var strInstructions: String
    public var ingredients: [Ingredient]
    public var strCategory: String
    public var strIBA: String?
    public var strAlcoholic: String
    public var strGlass: String
    
    public init(idDrink: String,
                strDrink: String,
                strDrinkThumb: String,
                strImageSource: String?,
                strInstructions: String,
                ingredients: [Ingredient],
                strCategory: String,
                strIBA: String?,
                strAlcoholic: String,
                strGlass: String) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        self.strImageSource = strImageSource
        self.strInstructions = strInstructions
        self.ingredients = ingredients
        self.strCategory = strCategory
        self.strIBA = strIBA
        self.strAlcoholic = strAlcoholic
        self.strGlass = strGlass
    }
}
