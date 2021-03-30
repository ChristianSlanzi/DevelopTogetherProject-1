//
//  SignupController.swift
//  LoginSignupModule
//

import Foundation

public protocol SignupControllerDelegate: class {
    func signupResult(result: Bool)
}

public class SignupController {
    
    let dummyUsername = "Alibaba"
    let dummyPassword = "Sesamo123"
    let dummyEmailAddress = "a@b.com"
    
    weak var signupControllerDelegate: SignupControllerDelegate?
    
    public init(delegate: SignupControllerDelegate?) {
        self.signupControllerDelegate = delegate
    }
    
    public func doSignup(model: SignupModel) {
        
        //dummy implementation
        
        let userName = model.userName
        let password = model.password
        let emailAddress = model.emailAddress
        
        if ((userName.compare(dummyUsername) == .orderedSame) &&
            (password.compare(dummyPassword) == .orderedSame) &&
            (emailAddress.compare(dummyEmailAddress) == .orderedSame)) {
            signupControllerDelegate?.signupResult(result: false)
            return
        }
        
        signupControllerDelegate?.signupResult(result: true)
    }
    
}
