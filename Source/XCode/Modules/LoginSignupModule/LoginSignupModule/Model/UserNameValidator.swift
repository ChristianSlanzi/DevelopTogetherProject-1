//
//  UserNameValidator.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 25.04.21.
//

import Foundation

public class UserNameValidator {

    public init() {}
    
    public func validate(_ value: String) -> Bool {
        
        if ((value.count < 2) || (value.count > 10)) {
            return false
        }
        
        let whitespace = Set(" ")
        if (value.filter {whitespace.contains($0)}).count > 0 {
            return false
        }
        
        let specialCharacters = Set("+-.,!@#$%^&*();\\/|<>\"")
        if (value.filter {specialCharacters.contains($0)}).count > 0 {
            return false
        }
        
        return true
    }
}
