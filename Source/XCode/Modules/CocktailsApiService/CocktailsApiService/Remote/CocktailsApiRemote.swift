//
//  CocktailsApiRemote.swift
//  CocktailsApiService
//
//  Created by Christian Slanzi on 03.06.21.
//

import NetworkingService

public class CocktailsApiRemote: CocktailsApiService {
    
    private var url: URL
    private var client: HTTPClient
    private var apiKey: String?

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
        self.apiKey = apiKey
    }
    
    public func searchCocktailByName(_ name: String, completion: @escaping (SearchResult) -> Void) {
        client.urlQueryParameters.add(value: "\(name)", forKey: "s")
        client.makeRequest(toURL: url.appendingPathComponent("search.php"), withHttpMethod: .get) { [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    public func searchCocktailsByFirstLetter(_ letter: Character) {
        
    }
}
