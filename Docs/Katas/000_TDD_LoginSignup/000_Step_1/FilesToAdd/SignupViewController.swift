//
//  SignupViewController.swift
//  LoginSignupModule
//
//  Created by Christian Slanzi on 21.03.21.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailAddressTextField.delegate = self
    }

    @IBAction func create (_ sender: Any) {

    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userNameDidEndOnExit(_ sender: Any) {
        
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: Any) {

    }
    
    @IBAction func confirmPasswordDidEndOnExit(_ sender: Any) {

    }
    
    @IBAction func emailAddressDidEndOnExit(_ sender: Any) {

    }
}

extension SignupViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            print(updatedString)
        }
        
        return true
    }
}
