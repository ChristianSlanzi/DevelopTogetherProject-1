//
//  LocalRecipe.swift
//  RecipeStore
//
//  Created by Christian Slanzi on 21.04.21.
//

import Foundation

public struct LocalRecipe: Equatable {
    
    public var id: Int
    public var calories: Int?
    public var carbs: String?
    public var fat: String?
    public var image: String
    public var imageType: String
    public var protein: String?
    public var title: String
    
    public init(id: Int, calories: Int? = nil, carbs: String? = nil,
                fat: String? = nil, image: String, imageType: String,
                protein: String? = nil, title: String) {
        self.id = id
        self.calories = calories
        self.carbs = carbs
        self.fat = fat
        self.image = image
        self.imageType = imageType
        self.protein = protein
        self.title = title
    }
}
