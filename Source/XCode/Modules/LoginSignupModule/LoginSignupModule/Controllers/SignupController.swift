//
//  SignupController.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 26.04.21.
//

import Foundation

public protocol SignupControllerDelegate: class {
    func signupResult(result: Bool, error: String?)
}

open class SignupController {
    
//    let dummyUsername = "Alibaba"
//    let dummyPassword = "Sesamo123"
//    let dummyEmailAddress = "a@b.com"
    
    open weak var signupControllerDelegate: SignupControllerDelegate?
    
    public var userApiService: LoginSignupService?
    
    public init(delegate: SignupControllerDelegate?) {
        self.signupControllerDelegate = delegate
    }
    
    open func doSignup(model: SignupModel) {
        
        //let userName = model.userName
        let emailAddress = model.emailAddress
        let password = model.password
        
        userApiService?.register(email: emailAddress, password: password, completion: { (result) in
            
            switch result {
            case .success(let registerData):
                print("registerData: " + registerData.description)
                
                DispatchQueue.main.async {
                    self.signupControllerDelegate?.signupResult(result: true, error: nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
                DispatchQueue.main.async {
                    self.signupControllerDelegate?.signupResult(result: false, error: error.localizedDescription)
                }
            }
        })
        
    }
    
}
