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
    
    public init(idDrink: String, strDrink: String, strDrinkThumb: String, strImageSource: String? = nil) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
        self.strImageSource = strImageSource
    }
}
