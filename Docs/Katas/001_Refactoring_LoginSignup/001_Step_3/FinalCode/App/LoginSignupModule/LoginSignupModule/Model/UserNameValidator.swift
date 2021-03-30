//
//  UserNameValidator.swift
//  LoginSignupModule
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
        
        guard let regexValidator = try? NSRegularExpression(pattern: "([A-Za-z0-9'])",
                                                            options: .caseInsensitive) else { return false }
        
        if regexValidator.numberOfMatches(in: value,
                                          options: NSRegularExpression.MatchingOptions.reportCompletion,
                                          range: NSMakeRange(0, value.count)) > 0 {
            return true
        }
        
        return false
    }
}
