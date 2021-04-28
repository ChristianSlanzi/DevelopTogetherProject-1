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
    
    weak var routing: LoginRouting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField?.delegate = self
        passwordTextField.delegate = self
        
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
        routing?.routeToSignupViewController()
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
        self.userNameTextField.text = ""
    }
    
    func clearPasswordField() {
        self.passwordTextField.text = ""
    }
    
    func enableLoginButton(_ status:Bool) {
        self.loginButton.isEnabled = status
    }
    
    func enableCreateAccountButton(_ status:Bool) {
        self.createAccountButton.isEnabled = status
    }
    
    func hideKeyboard() {
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func showLoginResult(_ result: Bool, error: String?) {
        
        let alert = UIAlertController(title: result ? "Congratulations" : "Error",
                                      message: result ? "Login was successful" : (error ?? "Username or Password not valid"),
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true) {
            if result == true {
                self.routing?.routeToMainViewController()
            }
        }
    }
    
}
