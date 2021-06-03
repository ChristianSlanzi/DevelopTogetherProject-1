//
//  CocktailsApiRemote.swift
//  CocktailsApiService
//
//  Created by Christian Slanzi on 03.06.21.
//

import NetworkingService

class CocktailsApiRemote: CocktailsApiService {
    
    private var url: URL
    private var client: HTTPClient
    private var apiKey: String?

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    
    func searchCocktailByName(_ name: String) {
        
    }
    
    func searchCocktailsByFirstLetter(_ letter: Character) {
        
    }
}
