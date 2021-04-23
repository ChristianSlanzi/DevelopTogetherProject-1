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
    
    func getUsersList(completion: @escaping (UserDataResult) -> Void)
    func getUsersList(page: Int?, completion: @escaping (UserDataResult) -> Void)
}
