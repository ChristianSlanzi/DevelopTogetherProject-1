//
//  RecipeDTO.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 20.04.21.
//

public struct RecipeDTO: Codable, CustomStringConvertible, Hashable {
    
    public var id: Int
    public var calories: Int?
    public var carbs: String?
    public var fat: String?
    public var image: String
    public var imageType: String
    public var protein: String?
    public var title: String

    public var description: String {
        return """
        ------------
        id = \(id)
        calories = \(calories ?? defInt)
        carbs = \(carbs ?? defString)
        fat = \(fat ?? defString)
        image = \(image)
        imageType = \(imageType)
        protein = \(protein ?? defString)
        title = \(title)
        ------------
        """
    }
}
