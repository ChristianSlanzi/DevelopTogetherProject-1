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
    
    internal init(idDrink: String, strDrink: String, strDrinkThumb: String, strImageSource: String? = nil, strInstructions: String, ingredients: [String]) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        self.strImageSource = strImageSource
        self.strInstructions = strInstructions
        self.ingredients = ingredients
    }
    
    public var name: String {
        return strDrink
    }
    
    public static func == (lhs: Drink, rhs: Drink) -> Bool {
        lhs.idDrink == rhs.idDrink
    }
}
