//
//  NutrientParameters.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 07.06.21.
//

import Foundation

public struct NutrientParameters {
    
    enum NumberParameters: String {
        case minCarbs
        case maxCarbs
        case minProtein
        case maxProtein
    }

    enum BooleanParameters: String {
        case random
        case limitLicense
    }
    
    let numbers: [NumberParameters: Int]
    let booleans: [BooleanParameters: Bool]
    
    var mapToDictionary: [String: Any] {
        get {
            var dictionary = [String: Any]()
            numbers.forEach() { dictionary[$0.key.rawValue] = $0.value }
            booleans.forEach() { dictionary[$0.key.rawValue] = $0.value }
            return dictionary
        }
    }
}
