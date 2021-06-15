//
//  Models.swift
//  UserApiService
//
//  Created by Christian Slanzi on 23.04.21.
//

import NetworkingService

var defString = String(stringLiteral: "")
var defInt = -1

public struct SingleUserData: DTO {
    var data: User?
    
    public var description: String {
        return """
        data = \(data?.description ?? defString)
        """
    }
}

public struct JobUser: DTO {
    var id: String
    var name: String?
    var job: String?
    var createdAt: String
    
    public var description: String {
        return """
        id = \(id)
        name = \(name ?? defString)
        job = \(job ?? defString)
        createdAt = \(createdAt)
        """
    }
}

public enum UserApiServiceError: Swift.Error {
    case connectivity
    case invalidData
}
