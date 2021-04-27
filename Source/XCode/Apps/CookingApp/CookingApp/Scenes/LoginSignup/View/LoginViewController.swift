//
//  LoginViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.viewModel == nil {
            self.viewModel = LoginViewModel(view: self)
        }
        
        self.viewModel?.performInitialViewSetup()
    }
}

extension LoginViewController : LoginViewControllerProtocol {
    
    func clearUserNameField() {
        
    }
    
    func clearPasswordField() {
        
    }
    
    func enableLoginButton(_ status: Bool) {
        
    }
    
    func enableCreateAccountButton(_ status: Bool) {
        
    }
    
    func hideKeyboard() {
        
    }
    
}
