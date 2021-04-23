//
//  UserApiRemote.swift
//  UserApiService
//
//  Created by Christian Slanzi on 23.04.21.
//

import NetworkingService


class UserApiRemote: UserApiService {
    
    private var url: URL
    private var client: HTTPClient
    // Inject the Networking service in the init through a protocol
    // to implement Inversion of Control.
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
}
