//
//  LoginSignupWrapper.swift
//  CookingApp
//
//  Created by Christian Slanzi on 28.04.21.
//

import LoginSignupModule
import UserApiService
import NetworkingService

class LoginSignupWrapper: LoginSignupService {
    
    static func mapError(_ error: UserApiService.ServiceError) -> LoginSignupModule.UserApiServiceError {
        switch error {
        case .connectivity:
            return LoginSignupModule.UserApiServiceError.connectivity
        case .invalidData:
            return LoginSignupModule.UserApiServiceError.invalidData
        }
    }
    
    static func mapData(_ data: UserApiService.ServiceLoginData) -> LoginSignupModule.LoginData {
        return LoginSignupModule.LoginData(token: data.token)
    }
    
    static func mapData(_ data: UserApiService.ServiceRegisterData) -> LoginSignupModule.RegisterData {
        return LoginSignupModule.RegisterData(id: data.id, token: data.token)
    }
    
    static let networkingService = URLSessionHTTPClient(session: URLSession(configuration: .default))
    let userApiService: UserApiService = UserApiServiceFactory(url: URL(string: "https://reqres.in/api")!, client: networkingService).getUserApiService()
    
    func login(email: String, password: String, completion: @escaping (LoginDataResult) -> Void) {
        
        userApiService.login(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(LoginSignupWrapper.mapError(error)))
            case .success(let loginData):
                completion(.success(LoginSignupWrapper.mapData(loginData)))
                break
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (RegisterDataResult) -> Void) {
        
        userApiService.register(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(LoginSignupWrapper.mapError(error)))
            case .success(let registerData):
                completion(.success(LoginSignupWrapper.mapData(registerData)))
                break
            }
        }
    }
    
    
}
