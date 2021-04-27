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
        
        userNameTextField?.delegate = self
        
        if self.viewModel == nil {
            self.viewModel = LoginViewModel(view: self)
        }
        
        self.viewModel?.performInitialViewSetup()
    }
    
    @IBAction func login(_ sender: Any) {
        viewModel?.login(userName: userNameTextField.text,
                         password: passwordTextField.text)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "presentCreateAccount", sender: self)
    }
    
    @IBAction func userNameDidEndOnExit(_ sender: Any) {
        viewModel?.userNameDidEndOnExit()
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: Any) {
        viewModel?.passwordDidEndOnExit()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        if textField == self.userNameTextField {
            self.viewModel?.userNameUpdated(updatedString)
        }
        
        if textField == self.passwordTextField {
            self.viewModel?.passwordUpdated(updatedString)
        }
        
        return true
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