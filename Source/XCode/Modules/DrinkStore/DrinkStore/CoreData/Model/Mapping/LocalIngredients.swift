//
//  LocalIngredients.swift
//  DrinkStore
//
//  Created by Christian Slanzi on 01.07.21.
//

import Foundation

public class LocalIngredients: NSObject, NSCoding {
    
    public var ingredients: [LocalIngredient] = []
    
    enum Key:String {
        case ingredients = "ingredients"
    }
    
    init(ingredients: [LocalIngredient]) {
        self.ingredients = ingredients
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(ingredients, forKey: Key.ingredients.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mIngredients = aDecoder.decodeObject(forKey: Key.ingredients.rawValue) as! [LocalIngredient]
        
        self.init(ingredients: mIngredients)
    }
    
    
}

public class LocalIngredient: NSObject, NSCoding {
    
    public var name: String = ""
    public var measure: String = ""
    
    enum Key:String {
        case name = "name"
        case measure = "measure"
    }
    
    init(name: String, measure: String) {
        self.name = name
        self.measure = measure
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(measure, forKey: Key.measure.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        let mname = aDecoder.decodeObject(forKey: Key.name.rawValue)
        let mmeasure = aDecoder.decodeObject(forKey: Key.measure.rawValue)
        
        self.init(name: mname as! String, measure: mmeasure as! String)
    }
}
