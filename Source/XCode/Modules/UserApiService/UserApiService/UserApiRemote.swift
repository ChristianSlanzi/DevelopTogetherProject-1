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
    
    // MARK: - getUsersList
    
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
            guard self != nil else { return }
            
            print("\n\nResponse HTTP Headers:\n")
             
            if let response = result.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
                
                if response.statusCode != 200 {
                    completion(.failure(.invalidData))
                    return
                }
            } else {
                completion(.failure(.connectivity))
                return
            }
            
            if let data = result.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userData = try? decoder.decode(UserData.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                print(userData.description)
                completion(.success(userData))
            } else {
                completion(.failure(.invalidData))
            }
        }
        
    }
    
    // MARK: - getSingleUser
    
    func getSingleUser(id: Int, completion: @escaping (SingleUserDataResult) -> Void) {
        var singleUserURL = url.appendingPathComponent("users")
        singleUserURL.appendPathComponent("\(id)")
             
        client.makeRequest(toURL: singleUserURL, withHttpMethod: .get) {  [weak self] result in
            guard self != nil else { return }
            
            print("\n\nResponse HTTP Headers:\n")
            
            if let response = result.response {
                for (key, value) in response.headers.allValues() {
                    print(key, value)
                }
                
                if response.statusCode != 200 {
                    completion(.failure(.invalidData))
                    return
                }
            } else {
                completion(.failure(.connectivity))
                return
            }
            
            if let data = result.data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let singleUserData = try? decoder.decode(SingleUserData.self, from: data) else {
                    completion(.failure(.invalidData))
                    return }
     
                completion(.success(singleUserData))
     
            } else {
                completion(.failure(.invalidData))
            }
        }
    }
    
    // MARK: - createUser
    
    func createUser(completion: @escaping (JobUserResult) -> Void) {
        client.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        client.httpBodyParameters.add(value: "John", forKey: "name")
        client.httpBodyParameters.add(value: "Developer", forKey: "job")
     
        client.makeRequest(toURL: url.appendingPathComponent("users"), withHttpMethod: .post) {  [weak self] result in
            guard self != nil else { return }
            
            guard let response = result.response else {
                completion(.failure(.connectivity))
                return
            }
            if response.statusCode == 201 {
                guard let data = result.data else {
                    completion(.failure(.invalidData))
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let jobUser = try? decoder.decode(JobUser.self, from: data) else {
                    completion(.failure(.invalidData))
                    return
                }
                print(jobUser.description)
                completion(.success(jobUser))
            }
            else {
                completion(.failure(.invalidData))
            }
        }
    }
}
