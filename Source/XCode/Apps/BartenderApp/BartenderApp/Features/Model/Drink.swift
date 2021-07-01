//
//  Drink.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 23.06.21.
//

import Foundation

public class Drink: Equatable {
    
    public class Ingredient: Equatable {
        
        var name: String
        var measure: String
        
        internal init(name: String = "", measure: String) {
            self.name = name
            self.measure = measure
        }
        
        public static func == (lhs: Drink.Ingredient, rhs: Drink.Ingredient) -> Bool {
            lhs.name == rhs.name && lhs.measure == rhs.measure
        }
    }
    
    
    var idDrink: String
    var strDrink: String
    var strDrinkThumb: String
    var strImageSource: String?
    var strInstructions: String
    var ingredients: [Ingredient]
    var strCategory: String
    var strIBA: String?
    var strAlcoholic: String
    var strGlass: String
    
    internal init(idDrink: String,
                  strDrink: String,
                  strDrinkThumb: String,
                  strImageSource: String? = nil,
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
    
    public var name: String {
        return strDrink
    }
    
    public static func == (lhs: Drink, rhs: Drink) -> Bool {
        lhs.idDrink == rhs.idDrink
    }
}
