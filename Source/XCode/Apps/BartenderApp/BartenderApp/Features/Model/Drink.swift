//
//  Drink.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 23.06.21.
//

import Foundation

public struct Drink: Equatable {
    var idDrink: String
    var strDrink: String
    var strDrinkThumb: String
    var strImageSource: String?
    
    public var name: String {
        return strDrink
    }
}
