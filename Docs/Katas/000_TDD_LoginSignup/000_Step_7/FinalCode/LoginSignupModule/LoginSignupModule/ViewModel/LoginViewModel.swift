//
//  LoginViewModel.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 22.03.21.
//

import Foundation

class LoginViewModel: NSObject {
    weak var view: LoginViewControllerProtocol?
    
    init(view: LoginViewControllerProtocol) {
        super.init()
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
}
