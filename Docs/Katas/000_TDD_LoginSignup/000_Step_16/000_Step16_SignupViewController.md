## Step 16: The SignupViewController

- The SignupViewController is built in the same TDD way as the LoginViewController. So you can complete it as an exercise, check against the provided implemented solution.

- Add a SignupViewControllerTests unit test class under Tests/View group:

  [SignupViewControllerTests](FilesToAdd/SignupViewControllerTests.swift)

- The tests won't compile - red flag. We need to add the mocked signup view model:
  [MockSignupViewModel](FilesToAdd/MockSignupViewModel.swift)

- Now we need to implement the SignupViewControllerProtocol:

```swift
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
```

- And we need to add the view model to the view controller and call its methods:

```swift
var viewModel: SignupViewModel?

override func viewDidLoad() {
  super.viewDidLoad()

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
```

- Run the tests - red flag.
- Fix the UITextFieldDelegate Extension in the SignupViewController:

```swift
extension LoginViewController: UITextFieldDelegate {
    
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    if let updatedString = (textField.text as NSString?)?
    												.replacingCharacters(in: range,
                                               with: string) {
      if textField == self.userNameTextField { 		
        self.viewModel?.userNameUpdated(textField.text)
      }
      if textField == self.passwordTextField { 
        self.viewModel?.passwordUpdated(textField.text)
      }
    }
    return true
  }
}
```

- Run the tests - green!

Now your project should look like this:
[Step_16_FinalCode](FinalCode/)



