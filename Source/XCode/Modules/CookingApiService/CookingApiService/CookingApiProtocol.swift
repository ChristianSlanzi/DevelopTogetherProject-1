//
//  CookingApiService.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 26.04.21.
//

import NetworkingService

public protocol CookingApiProtocol {
    typealias ServiceError = NetworkingServiceError//CookingApiServiceError
    typealias RecipesSearchResult = Swift.Result<RecipesSearchResultDTO, ServiceError>
    typealias RecipesSearchByIngredientsResult = Swift.Result<[RecipesSearchByIngredientsResultDTO], ServiceError>
    typealias RecipesSearchByNutrientsResult = Swift.Result<[RecipeDTO], ServiceError>
    typealias RecipeInformationResult = Swift.Result<RecipeInformationResultDTO, ServiceError>
    
    func searchRecipes(predicate: NSPredicate?, completion: @escaping (RecipesSearchResult) -> Void)
    //typedef Parameters [String: Any]
    func searchRecipesByNutrients(parameters: NutrientParameters, completion: @escaping (RecipesSearchByNutrientsResult) -> Void)
    func searchRecipesByIngredients(parameters: String, completion: @escaping (RecipesSearchByIngredientsResult) -> Void)
    func getRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationResult) -> Void)
    
}

public class CookingApiServiceFactory {
    private let url: URL
    private var client: HTTPClient
    private var apiKey: String?
    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    public func getCookingApiService() -> CookingApiProtocol {
        return CookingApiRemote(url: url, client: client, apiKey: apiKey)
    }
}
