//
//  CookingApiService.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 26.04.21.
//

import Foundation

public protocol CookingApiService {
    typealias ServiceError = CookingApiServiceError
    typealias RecipesSearchResult = Swift.Result<RecipesSearchResultDTO, ServiceError>
    
    func searchRecipes(completion: @escaping (RecipesSearchResult) -> Void)
}
