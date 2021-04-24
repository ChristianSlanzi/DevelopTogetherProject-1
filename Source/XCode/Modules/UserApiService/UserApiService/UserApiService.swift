//
//  UserApiService.swift
//  UserApiService
//
//  Created by Christian Slanzi on 23.04.21.
//

import NetworkingService

public protocol UserApiService {
    
    typealias ServiceError = UserApiServiceError
    typealias ServiceLoginData = LoginData
    typealias ServiceRegisterData = RegisterData
    
    typealias UserDataResult = Swift.Result<UserData, ServiceError>
    typealias SingleUserDataResult = Swift.Result<SingleUserData, ServiceError>
    typealias DataResult = Swift.Result<Data, ServiceError>
    typealias JobUserResult = Swift.Result<JobUser, ServiceError>
    
    typealias LoginDataResult = Swift.Result<LoginData, ServiceError>
    typealias RegisterDataResult = Swift.Result<RegisterData, ServiceError>
    
    func getUsersList(completion: @escaping (UserDataResult) -> Void)
    func getUsersList(page: Int?, completion: @escaping (UserDataResult) -> Void)
    
    func getSingleUser(id: Int, completion: @escaping (SingleUserDataResult) -> Void)
    
    func createUser(completion: @escaping (JobUserResult) -> Void)
    
    func login(email: String, password: String, completion: @escaping (LoginDataResult) -> Void)
    func register(email: String, password: String, completion: @escaping (RegisterDataResult) -> Void)
}

public class UserApiServiceFactory {
    private let url: URL
    private var client: HTTPClient
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    public func getUserApiService() -> UserApiService {
        return UserApiRemote(url: url, client: client)
    }
}
