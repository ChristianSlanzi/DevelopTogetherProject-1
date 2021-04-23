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
    
    func getUsersList(completion: @escaping (UserDataResult) -> Void) {
        getUsersList(page: nil) { (result) in
            completion(result)
        }
    }
    
    func getUsersList(page: Int?, completion: @escaping (UserDataResult) -> Void) {
        
        if let usersPage = page {
            client.urlQueryParameters.add(value: "\(usersPage)", forKey: "page")
        }
        
        client.makeRequest(toURL: url.appendingPathComponent("users"), withHttpMethod: .get) { [weak self] result in
            
            print("\n\nResponse HTTP Headers:\n")
             
            if let response = result.response {

            } else {
                completion(.failure(.connectivity))
                return
            }
            
        }
        
    }
}
