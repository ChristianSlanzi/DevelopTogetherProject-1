//
//  Errors.swift
//  CookingApiService
//
//  Created by Christian Slanzi on 20.04.21.
//

public enum CookingApiServiceError: Swift.Error {
    case connectivity
    case invalidData
    case notAuthorized
}
