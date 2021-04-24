//
//  Models.swift
//  UserApiService
//
//  Created by Christian Slanzi on 23.04.21.
//

import Foundation

var defString = String(stringLiteral: "")
var defInt = -1

public struct UserData: Codable,
                        CustomStringConvertible,
                        Hashable {
    var page: Int?
    var perPage: Int?
    var total: Int?
    var totalPages: Int?
    var data: [User]?
    
    public var description: String {
        var desc = """
        page = \(page ?? defInt)
        records per page = \(perPage ?? defInt)
        total records = \(total ?? defInt)
        total pages = \(totalPages ?? defInt)
        Users:
        
        """
        if let users = data {
            for user in users {
                desc += user.description
            }
        }
        
        return desc
    }
}

public struct User: Codable, CustomStringConvertible, Hashable {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var avatar: String?

    public var description: String {
        return """
        ------------
        id = \(id ?? defInt)
        firstName = \(firstName ?? defString)
        lastName = \(lastName ?? defString)
        avatar = \(avatar ?? defString)
        ------------
        """
    }
}

public struct SingleUserData: Codable, Hashable {
    var data: User?
}

public struct JobUser: Codable, CustomStringConvertible, Hashable {
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
