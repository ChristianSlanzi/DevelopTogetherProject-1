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
    
    public var name: String {
        return strDrink
    }
}
