//
//  CookingApiRemote.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 26.04.21.
//

import NetworkingService

class GenericDecoder {
    static func decodeResult<T: DTO> (result: HTTPClientResult) -> Swift.Result<T, CookingApiService.ServiceError> {
        print("\n\nResponse HTTP Headers:\n")
        
        if let response = result.response {
            for (key, value) in response.headers.allValues() {
                print(key, value)
            }
            
            if response.statusCode != 200 {
                return .failure(.invalidData)
            }
        }  else {
            return .failure(.connectivity)
        }
        
        if let data = result.data {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let jsonStr = String(decoding: data, as: UTF8.self)
                print(jsonStr)
                let userData = try decoder.decode(T.self, from: data)
                print(userData.description)
                return .success(userData)
            } catch {
                print(error)
                return .failure(.invalidData)
            }
        } else {
            return .failure(.invalidData)
        }
    }
}

class CookingApiRemote: CookingApiService {
    
    private var url: URL
    private var client: HTTPClient
    private var apiKey: String?

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    
    func searchRecipes(completion: @escaping (RecipesSearchResult) -> Void) {
        
        if let key = apiKey {
            client.urlQueryParameters.add(value: "\(key)", forKey: "apiKey")
        }
        
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
