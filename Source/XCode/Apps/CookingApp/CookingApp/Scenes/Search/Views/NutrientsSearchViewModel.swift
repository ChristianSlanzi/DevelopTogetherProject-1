//
//  NutrientsSearchViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 08.06.21.
//

import Foundation

class NutrientsSearchViewModel {
    
    var minCarbsValue: Int? = nil
    var maxCarbsValue: Int? = nil
    var minProteinValue: Int? = nil
    var maxProteinValue: Int? = nil
    
    weak var view: NutrientsSearchViewProtocol?
    
    init() {
        
    }
    
    func minCarbsValueUpdated(_ value: Int) {
        minCarbsValue = value
    }
    
    func maxCarbsValueUpdated(_ value: Int) {
        maxCarbsValue = value
    }
    
    func minProteinValueUpdated(_ value: Int) {
        minProteinValue = value
    }
    
    func maxProteinValueUpdated(_ value: Int) {
        maxProteinValue = value
    }
    
    func onSearchButtonPressed() {
        var nutrients = [String: Int]()
        if let minCarbs = minCarbsValue { nutrients["minCarbs"] = minCarbs }
        if let maxCarbs = maxCarbsValue { nutrients["maxCarbs"] = maxCarbs }
        if let minProtein = minProteinValue { nutrients["minProtein"] = minProtein }
        if let maxProtein = maxProteinValue { nutrients["maxProtein"] = maxProtein }
        view?.searchRecipesForNutrients(nutrients)
    }
}
