//
//  UserData.swift
//  UserApiService
//
//  Created by Christian Slanzi on 15.06.21.
//

import NetworkingService

public struct UserData: DTO {
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
