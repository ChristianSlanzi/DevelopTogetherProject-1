//
//  PasswordValidator.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 25.04.21.
//

import Foundation

public class PasswordValidator {
    
    public init() {}
    
    public func validate(_ value: String) -> Bool {
        if ((value.count <= 0) ) {
            return false
        }
        
        return true
    }
}
