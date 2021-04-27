//
//  LoginViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation

class LoginViewModel {
    
    weak var view: LoginViewControllerProtocol?
    
    init(view: LoginViewControllerProtocol) {
               
        self.view = view
    }
    
    func performInitialViewSetup() {
        view?.clearUserNameField()
        view?.clearPasswordField()
    }
}
