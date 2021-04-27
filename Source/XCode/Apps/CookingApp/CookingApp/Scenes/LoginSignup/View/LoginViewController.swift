//
//  LoginViewController.swift
//  CookingApp
//
//  Created by Christian Slanzi on 27.04.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.viewModel == nil {
            self.viewModel = LoginViewModel(view: self)
        }
        
        self.viewModel?.performInitialViewSetup()
    }
    
    @IBAction func login(_ sender: Any) {

        
    }
    
    @IBAction func createAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "presentCreateAccount", sender: self)
    }
    
    @IBAction func userNameDidEndOnExit(_ sender: Any) {
        viewModel?.userNameDidEndOnExit()
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: Any) {

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
