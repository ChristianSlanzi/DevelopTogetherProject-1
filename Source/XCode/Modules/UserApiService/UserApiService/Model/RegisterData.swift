//
//  RegisterData.swift
//  UserApiService
//
//  Created by Christian Slanzi on 15.06.21.
//

import NetworkingService

public struct RegisterData: DTO {
    
    public var id: Int
    public var token: String?

    public var description: String {
        return """
        ------------
        token = \(token ?? defString)
        ------------
        """
    }
}
