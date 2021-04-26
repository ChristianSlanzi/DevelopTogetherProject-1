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
        if ((value.count < 6) || (value.count > 10)) {
            return false
        }
        
        let whitespace = Set(" ")
        if (value.filter {whitespace.contains($0)}).count > 0 {
            return false
        }

        let uppercaseAlphabets = Set("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if (value.filter {uppercaseAlphabets.contains($0)}).count == 0 {
            return false
        }
        
        let lowercaseAlphabets = Set("abcdefghijklmnopqrstuvwxyz")
        if (value.filter {lowercaseAlphabets.contains($0)}).count == 0 {
            return false
        }
        
        let numbers = Set("0123456789")
        if (value.filter {numbers.contains($0)}).count == 0 {
            return false
        }
        
        return true
    }
}
