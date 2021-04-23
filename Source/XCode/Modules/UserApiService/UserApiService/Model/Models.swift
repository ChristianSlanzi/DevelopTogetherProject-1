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
    
    public var description: String {
        var desc = """
        
        """
        return desc
    }
}

public enum UserApiServiceError: Swift.Error {
    case connectivity
    case invalidData
}
