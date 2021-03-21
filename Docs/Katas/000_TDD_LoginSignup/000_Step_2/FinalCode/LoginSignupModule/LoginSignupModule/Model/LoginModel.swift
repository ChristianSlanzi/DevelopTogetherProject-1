//
//  LoginModel.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 21.03.21.
//

import Foundation

class LoginModel: NSObject {
  
  var userName: String
  var password: String

    init?(userName: String,
          password: String,
          userNameValidator: UserNameValidator? = nil) {
        
        self.userName = userName
        self.password = password
        
        let validator1 = userNameValidator ?? UserNameValidator()
        if validator1.validate(userName) == false {
            return nil
        }
    }
}
