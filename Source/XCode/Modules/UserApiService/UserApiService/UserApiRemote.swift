//
//  UserApiRemote.swift
//  UserApiService
//
//  Created by Christian Slanzi on 23.04.21.
//

import NetworkingService

class GenericDecoder {
    static func decodeResult<T: DTO> (result: HTTPClientResult, validStatusCode: Int = 200) -> Swift.Result<T, UserApiService.ServiceError> {
        print("\n\nResponse HTTP Headers:\n")
        
        if let response = result.response {
            for (key, value) in response.headers.allValues() {
                print(key, value)
            }
            
            if response.statusCode != validStatusCode {
                return .failure(.invalidData)
            }
        }  else {
            return .failure(.connectivity)
        }
        
        if let data = result.data {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let userData = try? decoder.decode(T.self, from: data) else {
                return .failure(.invalidData)
            }
            
            print(userData.description)
            return .success(userData)
            
        } else {
            return .failure(.invalidData)
        }
    }
}

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
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    // MARK: - getSingleUser
    
    func getSingleUser(id: Int, completion: @escaping (SingleUserDataResult) -> Void) {
        var singleUserURL = url.appendingPathComponent("users")
        singleUserURL.appendPathComponent("\(id)")
             
        client.makeRequest(toURL: singleUserURL, withHttpMethod: .get) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    // MARK: - createUser
    
    func createUser(completion: @escaping (JobUserResult) -> Void) {
        client.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        client.httpBodyParameters.add(value: "John", forKey: "name")
        client.httpBodyParameters.add(value: "Developer", forKey: "job")
     
        client.makeRequest(toURL: url.appendingPathComponent("users"), withHttpMethod: .post) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result, validStatusCode: 201))
        }
    }
    
    // MARK: - login
    
    func login(email: String, password: String, completion: @escaping (LoginDataResult) -> Void) {
        
        client.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        client.httpBodyParameters.add(value: "eve.holt@reqres.in", forKey: "email")
        client.httpBodyParameters.add(value: "cityslicka", forKey: "password")
     
        client.makeRequest(toURL: url.appendingPathComponent("login"), withHttpMethod: .post) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
    
    // MARK: - register
    
    func register(email: String, password: String, completion: @escaping (RegisterDataResult) -> Void) {
        
        client.requestHttpHeaders.add(value: "application/json", forKey: "Content-Type")
        client.httpBodyParameters.add(value: "eve.holt@reqres.in", forKey: "email")
        client.httpBodyParameters.add(value: "pistol", forKey: "password")
     
        client.makeRequest(toURL: url.appendingPathComponent("register"), withHttpMethod: .post) {  [weak self] result in
            guard self != nil else { return }
            
            completion(GenericDecoder.decodeResult(result: result))
        }
    }
}
