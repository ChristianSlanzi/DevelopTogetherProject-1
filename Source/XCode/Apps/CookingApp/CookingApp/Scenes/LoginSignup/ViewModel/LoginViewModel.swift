//
//  LoginViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import LoginSignupModule

class LoginViewModel {
    
    weak var view: LoginViewControllerProtocol?
    
    var userNameValidator: UserNameValidator?
    var passwordValidator: PasswordValidator?
    var userNameValidated: Bool
    var passwordValidated: Bool
    
    init(view: LoginViewControllerProtocol) {
        self.userNameValidated = false
        self.passwordValidated = false
        self.view = view
    }
    
    func performInitialViewSetup() {
        view?.clearUserNameField()
        view?.clearPasswordField()
        view?.enableLoginButton(false)
        view?.enableCreateAccountButton(true)
        view?.hideKeyboard()
    }
    
    func userNameDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func passwordDidEndOnExit() {
        view?.hideKeyboard()
    }
    
    func userNameUpdated(_ value: String?) {
        
        guard let value = value else {
            view?.enableLoginButton(false)
            return
        }
        
        let validator = self.userNameValidator ?? UserNameValidator()
        userNameValidated = validator.validate(value)
        
        if userNameValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        if passwordValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        view?.enableLoginButton(true)
    }
    
    func passwordUpdated(_ value: String?) {
        
        guard let value = value else {
            view?.enableLoginButton(false)
            return
        }
        
        let validator = self.passwordValidator ?? PasswordValidator()
        passwordValidated = validator.validate(value)
        
        if userNameValidated == false {
            view?.enableLoginButton(false)
            return
        }
        
        view?.enableLoginButton(true)
    }
}
