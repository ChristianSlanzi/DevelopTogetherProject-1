//
//  LoginController.swift
//  LoginSignupModule
//

import Foundation

public protocol LoginControllerDelegate: class {
    func loginResult(result: Bool)
}

public class LoginController {
    let dummyUsername = "Alibaba"
    let dummyPassword = "Sesamo123"
   
    weak var loginControllerDelegate: LoginControllerDelegate?

    public init(delegate: LoginControllerDelegate?) {
        self.loginControllerDelegate = delegate
    }
    
    public func doLogin(model: LoginModel) {
        let userName = model.userName
        let password = model.password
        
        if ((userName.compare(dummyUsername) == .orderedSame)
                && (password.compare(dummyPassword) == .orderedSame)) {
            loginControllerDelegate?.loginResult(result: true)
            return
        }
        
        loginControllerDelegate?.loginResult(result: false)
    }
    
}
