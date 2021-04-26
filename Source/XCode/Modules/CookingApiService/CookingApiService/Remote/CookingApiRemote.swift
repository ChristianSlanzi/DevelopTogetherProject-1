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

    public init(url: URL, client: HTTPClient, apiKey: String? = nil) {
        self.url = url
        self.client = client
    }
}
