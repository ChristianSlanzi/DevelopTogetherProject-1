//
//  LoginSignupService.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 26.04.21.
//

import Foundation

var defString = String(stringLiteral: "")

public struct LoginData: CustomStringConvertible, Hashable {
    
    public init(token: String?) {
        self.token = token
    }
    
    var token: String?

    public var description: String {
        return """
        ------------
        token = \(token ?? defString)
        ------------
        """
    }
}

public struct RegisterData: CustomStringConvertible, Hashable {
    
    public init(id: Int, token: String?) {
        self.id = id
        self.token = token
    }
    
    var id: Int
    var token: String?

    public var description: String {
        return """
        ------------
        token = \(token ?? defString)
        ------------
        """
    }
}

public enum UserApiServiceError: Swift.Error {
    case connectivity
    case invalidData
}

public protocol LoginSignupService {

    typealias LoginDataResult = Swift.Result<LoginData, ServiceError>
    typealias RegisterDataResult = Swift.Result<RegisterData, ServiceError>
    typealias ServiceError = UserApiServiceError

    func login(email: String, password: String, completion: @escaping (LoginDataResult) -> Void)
    func register(email: String, password: String, completion: @escaping (RegisterDataResult) -> Void)
}
