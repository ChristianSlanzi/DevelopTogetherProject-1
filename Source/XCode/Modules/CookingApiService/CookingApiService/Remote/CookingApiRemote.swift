//
//  CookingApiRemote.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 26.04.21.
//

import NetworkingService

class CookingApiRemote: CookingApiService {
    
    private var url: URL
    private var client: HTTPClient
    private var apiKey: String?

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    
    func searchRecipes(query: String = "", completion: @escaping (RecipesSearchResult) -> Void) {
        
        if let key = apiKey {
            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
        }
        
        client.urlQueryParameters.add(value: "\(query)", forKey: "query")
        
        client.makeRequest(toURL: url.appendingPathComponent("recipes/complexSearch"), withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    func getRecipeInformation(recipeId: Int, completion: @escaping (RecipeInformationResult) -> Void) {
        //https://api.spoonacular.com/recipes/{id}/information
        
        if let key = apiKey {
            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
        }
        
        client.makeRequest(toURL: url.appendingPathComponent("recipes/\(recipeId)/information"), withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            //print(result.response)
            
            //TODO
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
}
