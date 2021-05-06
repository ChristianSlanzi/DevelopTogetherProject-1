//
//  RecipesSearchResult.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 20.04.21.
//

var defString = String(stringLiteral: "")
var defInt = -1

public protocol DTO: Codable, CustomStringConvertible, Hashable {
    
}
public struct RecipesSearchResultDTO: DTO {
    
    public var offset: Int
    public var number: Int
    public var results: [RecipeDTO]
    public var totalResults: Int

    public var description: String {
        return """
        ------------
        offset = \(offset)
        number = \(number)
        results = \(results.description)
        totalResults = \(totalResults)
        ------------
        """
    }
}
