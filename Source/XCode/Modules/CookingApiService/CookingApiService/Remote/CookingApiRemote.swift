//
//  CookingApiRemote.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 26.04.21.
//

import NetworkingService

class CookingApiRemote: CookingApiProtocol {
    
    private var url: URL
    private var client: HTTPClient
    private var apiKey: String?

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    
    func searchRecipesByTitle(_ title: String, completion: @escaping (RecipesSearchResult) -> Void) {
        client.urlQueryParameters.add(value: title, forKey: "query")
        makeClientGetRequest(path: "recipes/complexSearch", completion: completion)
    }
    
    func searchRecipesByNutrients(parameters: NutrientParameters,
                                  completion: @escaping (RecipesSearchByNutrientsResult) -> Void) {
        
        parameters.mapToDictionary.forEach { (key, value) in
            client.urlQueryParameters.add(value: "\(value)", forKey: key)
        }
        
        makeClientGetRequest(path: "recipes/findByNutrients", completion: completion)
        
//        if let key = apiKey {
//            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
//        }
//
//        client.makeRequest(toURL: url.appendingPathComponent("recipes/findByNutrients"), withHttpMethod: .get) { [weak self] result in
//            guard self != nil else { return }
//
//            completion(GenericDecoder.decodeResult(result: result))
//        }
    }
    
    func searchRecipesByIngredients(_ ingredients: [String], completion: @escaping (RecipesSearchByIngredientsResult) -> Void) {
        
        client.urlQueryParameters.add(value: ingredients.joined(separator: ","), forKey: "ingredients")
        
        makeClientGetRequest(path: "recipes/findByIngredients", completion: completion)
        
//        if let key = apiKey {
//            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
//        }
//
//        client.makeRequest(toURL: url.appendingPathComponent("recipes/findByIngredients"), withHttpMethod: .get) { [weak self] result in
//            guard self != nil else { return }
//
//            completion(GenericDecoder.decodeResult(result: result))
//        }
    }
    
    func searchRecipes(predicate: NSPredicate?, completion: @escaping (RecipesSearchResult) -> Void) {
        
        //TODO: different queries based on query's key?
        if let predicate = predicate {
            client.urlQueryParameters.add(value: predicate.predicateFormat.replacingOccurrences(of: "title CONTAINS[c] ", with: "").replacingOccurrences(of: "\"", with: ""), forKey: "query")
        }
        
        makeClientGetRequest(path: "recipes/complexSearch", completion: completion)
        
//        if let key = apiKey {
//            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
//        }
//
//        client.makeRequest(toURL: url.appendingPathComponent("recipes/complexSearch"), withHttpMethod: .get) { [weak self] result in
//            guard self != nil else { return }
//
//            completion(GenericDecoder.decodeResult(result: result))
//        }
    }
    
    func getRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationResult) -> Void) {
        //https://api.spoonacular.com/recipes/{id}/information
        
        if let key = apiKey {
            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
        }
        
        makeClientGetRequest(path: "recipes/\(recipeId)/information", completion: completion)
        
        
//        client.makeRequest(toURL: url.appendingPathComponent("recipes/\(recipeId)/information"), withHttpMethod: .get) { [weak self] result in
//            guard self != nil else { return }
//
//            completion(GenericDecoder.decodeResult(result: result))
//        }
    }
    
    private func makeClientGetRequest<T: DTO>(path: String, completion: @escaping (Swift.Result<T, NetworkingServiceError>) -> Void) {
        if let key = apiKey {
            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
        }
        
        client.makeRequest(toURL: url.appendingPathComponent(path), withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
}
