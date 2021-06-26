//
//  FavoriteDrink.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 25.06.21.
//

import Foundation

public struct FavoriteDrink: Equatable {
    
    public var idDrink: String
    
    public init(idDrink: String) {
        self.idDrink = idDrink
    }
}
