//
//  User.swift
//  UserApiService
//
//  Created by Christian Slanzi on 15.06.21.
//

import NetworkingService

public struct User: DTO {
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
