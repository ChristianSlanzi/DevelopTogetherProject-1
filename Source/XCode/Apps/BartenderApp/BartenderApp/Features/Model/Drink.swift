//
//  Drink.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 23.06.21.
//

import Foundation

public class Drink: Equatable {
    
    var idDrink: String
    var strDrink: String
    var strDrinkThumb: String
    var strImageSource: String?
    var strInstructions: String
    var ingredients: [String]
    var strCategory: String
    var strIBA: String?
    var strAlcoholic: String
    var strGlass: String
    
    internal init(idDrink: String,
                  strDrink: String,
                  strDrinkThumb: String,
                  strImageSource: String? = nil,
                  strInstructions: String,
                  ingredients: [String],
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
