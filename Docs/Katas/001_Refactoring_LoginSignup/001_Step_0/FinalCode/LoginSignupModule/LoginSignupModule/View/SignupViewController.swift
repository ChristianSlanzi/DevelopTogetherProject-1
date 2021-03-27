//
//  SignupViewController.swift
//  LoginSignupModule
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var viewModel: SignupViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField?.delegate = self
        passwordTextField?.delegate = self
        confirmPasswordTextField?.delegate = self
        emailAddressTextField?.delegate = self
        
        if self.viewModel == nil {
            self.viewModel = SignupViewModel(view: self)
        }
        
        self.viewModel?.performInitialViewSetup()

    }

    @IBAction func create (_ sender: Any) {
        viewModel?.signup(userName: userNameTextField.text,
                          password: passwordTextField.text,
                          emailAddress: emailAddressTextField.text)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userNameDidEndOnExit(_ sender: Any) {
        viewModel?.userNameDidEndOnExit()
    }
    
    @IBAction func passwordDidEndOnExit(_ sender: Any) {
        viewModel?.passwordDidEndOnExit()
    }
    
    @IBAction func confirmPasswordDidEndOnExit(_ sender: Any) {
        viewModel?.confirmPasswordDidEndOnExit()
    }
    
    @IBAction func emailAddressDidEndOnExit(_ sender: Any) {
        viewModel?.emailAddressDidEndOnExit()
    }
}

extension SignupViewController: UITextFieldDelegate {
    
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
        
        if textField == self.confirmPasswordTextField {
            self.viewModel?.confirmPasswordUpdated(updatedString)
        }
        
        if textField == self.emailAddressTextField {
            self.viewModel?.emailAddressUpdated(updatedString)
        }
        
        return true
    }
}

extension SignupViewController : SignupViewControllerProtocol {
    
    func clearUserNameField() {
        self.userNameTextField.text = ""
    }
    
    func clearPasswordField() {
        self.passwordTextField.text = ""
    }
    
    func clearConfirmPasswordField() {
        self.confirmPasswordTextField.text = ""
    }
    
    
    func enableCancelButton(_ status:Bool) {
        self.cancelButton.isEnabled = status
    }
    
    func enableCreateButton(_ status:Bool) {
        self.createButton.isEnabled = status
    }
    
    func hideKeyboard() {
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.confirmPasswordTextField.resignFirstResponder()
    }
    
    func showSignupResult(_ result: Bool) {
        let alert = UIAlertController(title: result ? "Congratulations" : "Error",
                                      message: result ? "Signup was successful" : "Already registered user",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
