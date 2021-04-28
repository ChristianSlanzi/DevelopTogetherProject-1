//
//  LoginController.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 26.04.21.
//

import Foundation

public protocol LoginControllerDelegate: class {
    func loginResult(result: Bool, error: String?)
}

open class LoginController {

    public weak var loginControllerDelegate: LoginControllerDelegate?
    
    public var userApiService: LoginSignupService?

    public init(delegate: LoginControllerDelegate?) {
        self.loginControllerDelegate = delegate
    }
    
    open func doLogin(model: LoginModel) {
        let userName = model.userName
        let password = model.password
        
        
        userApiService?.login(email: userName, password: password) { result in
            switch result {
            case .success(let loginData):
                print("loginData: " + loginData.description)
                
                DispatchQueue.main.async {
                    self.loginControllerDelegate?.loginResult(result: true, error: nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
                DispatchQueue.main.async {
                    self.loginControllerDelegate?.loginResult(result: false, error: error.localizedDescription)
                }
            }
        }
    }
    
}
