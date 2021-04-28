//
//  SignupModel.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 25.04.21.
//

import Foundation

public class SignupModel {

    var userName: String
    var password: String
    var emailAddress: String
    
    public init?(userName: String, password: String, emailAddress: String,
          userNameValidator: UserNameValidator? = nil,
          passwordValidator: PasswordValidator? = nil,
          emailAddressValidator: EmailAddressValidator? = nil) {
        
        let validator1 = userNameValidator ?? UserNameValidator()
        if validator1.validate(userName) == false {
            return nil
        }
        
        let validator2 = passwordValidator ?? PasswordValidator()
        if validator2.validate(password) == false {
            return nil
        }
        
        let validator3 = emailAddressValidator ?? EmailAddressValidator()
        if validator3.validate(emailAddress) == false {
            return nil
        }
        
        self.userName = userName
        self.password = password
        self.emailAddress = emailAddress
        
    }
    
    public func getUsername() -> String {
        return userName
    }
    
    public func getEmailAddress() -> String {
        return emailAddress
    }
    
    public func getPassword() -> String {
        return password
    }
    
}
