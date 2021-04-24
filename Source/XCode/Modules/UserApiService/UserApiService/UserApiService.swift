//
//  UserApiService.swift
//  UserApiService
//
//  Created by Christian Slanzi on 23.04.21.
//

import NetworkingService

public protocol UserApiService {
    
    typealias ServiceError = UserApiServiceError
    
    typealias UserDataResult = Swift.Result<UserData, ServiceError>
    typealias DataResult = Swift.Result<Data, ServiceError>
    typealias JobUserResult = Swift.Result<JobUser, ServiceError>
    
    func getUsersList(completion: @escaping (UserDataResult) -> Void)
    func getUsersList(page: Int?, completion: @escaping (UserDataResult) -> Void)
    
    func createUser(completion: @escaping (JobUserResult) -> Void)
}
