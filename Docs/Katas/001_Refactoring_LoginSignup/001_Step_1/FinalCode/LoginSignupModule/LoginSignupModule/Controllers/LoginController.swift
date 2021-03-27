//
//  LoginController.swift
//  LoginSignupModule
//

import Foundation

protocol LoginControllerDelegate: class {
    func loginResult(result: Bool)
}

class LoginController: NSObject {
    let dummyUsername = "Alibaba"
    let dummyPassword = "Sesamo123"
   
    weak var loginControllerDelegate: LoginControllerDelegate?

    init(delegate: LoginControllerDelegate?) {
        self.loginControllerDelegate = delegate
        super.init()
    }
    
    func doLogin(model: LoginModel) {
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
