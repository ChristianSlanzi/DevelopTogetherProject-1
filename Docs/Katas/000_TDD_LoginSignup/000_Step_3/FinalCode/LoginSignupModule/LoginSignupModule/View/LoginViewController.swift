//
//  LoginViewController.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 21.03.21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self

    }
    
    @IBAction func login(_ sender: Any) {

    }
    
    @IBAction func createAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "presentCreateAccount", sender: self)
    }
    
    @IBAction func userNameDidEndOnExit(_ sender: Any) {
        
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: Any) {
        
    }

}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range,
                                                                                  with: string) {
            print(updatedString)
        }
        return true
    }
}
