//
//  CocktailsApiService.swift
//  CocktailsApiService
//
//  Created by Christian Slanzi on 03.06.21.
//

import NetworkingService

public protocol CocktailsApiService {
    typealias ServiceError = NetworkingServiceError
    typealias SearchResult = Swift.Result<CocktailsSearchAnswerDTO, ServiceError>
    //Search cocktail by name
    func searchCocktailByName(_ name: String, completion: @escaping (SearchResult) -> Void)
    func searchCocktailsByFirstLetter(_ letter: Character, completion: @escaping (SearchResult) -> Void)
}
