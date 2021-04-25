//
//  LoginModel.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 24.04.21.
//

import Foundation

public class LoginModel {
    
    var userName: String
    var password: String
    
    public init?(userName: String,
          password: String,
          userNameValidator: UserNameValidator? = nil,
          passwordValidator: PasswordValidator? = nil) {
        
        let validator1 = userNameValidator ?? UserNameValidator()
        if validator1.validate(userName) == false {
            return nil
        }
        
        let validator2 = passwordValidator ?? PasswordValidator()
        if validator2.validate(password) == false {
            return nil
        }
        
        self.userName = userName
        self.password = password
    }
}
