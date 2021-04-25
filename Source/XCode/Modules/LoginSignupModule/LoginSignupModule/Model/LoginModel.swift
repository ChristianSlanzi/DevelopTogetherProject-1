//
//  LoginModel.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 24.04.21.
//

import Foundation

public class LoginModel {
    
    public init?(userName: String,
          password: String,
          userNameValidator: UserNameValidator? = nil) {
        
        let validator1 = userNameValidator ?? UserNameValidator()
        if validator1.validate(userName) == false {
            return nil
        }
    }
}
