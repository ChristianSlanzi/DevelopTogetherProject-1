## Step 15: Test the TextFields events

- Let's test that when TextField's events are called, so the view model gets updated:

```swift
func testTextFieldShouldChangeCharacters_userNameTextField_Calls_UserNameUpdated_OnViewModel_WithExpectedUsername() {
        
  let expectation = self.expectation(description: "expected userNameUpdated() to be called")

  let userNameTextFieldStub = UITextFieldStub(text: validUserName)
  let passwordTextFieldStub = UITextFieldStub(text: validPassword)

  let loginViewController = LoginViewController()
  loginViewController.userNameTextField = userNameTextFieldStub
  loginViewController.passwordTextField = passwordTextFieldStub

  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.userNameUpdatedExpectation = (expectation,
                                          expectedValue: validUserName)

  loginViewController.viewModel = viewModel

  let _ = loginViewController.textField(userNameTextFieldStub,
                                        shouldChangeCharactersIn: NSMakeRange(0, 1),
                                        replacementString: "A")

  self.waitForExpectations(timeout: 1.0, handler: nil)
}
    
func testTextFieldShouldChangeCharacters_passwordTextField_Calls_PasswordUpdated_OnViewModel_WithExpectedUsername() {

  let expectation = self.expectation(description: "expected passwordUpdated() to be called")

  let userNameTextFieldStub = UITextFieldStub(text: validUserName)
  let passwordTextFieldStub = UITextFieldStub(text: validPassword)

  let loginViewController = LoginViewController()
  loginViewController.userNameTextField = userNameTextFieldStub
  loginViewController.passwordTextField = passwordTextFieldStub

  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.passwordUpdatedExpectation = (expectation,
                                          expectedValue: validPassword)

  loginViewController.viewModel = viewModel

  let _ = loginViewController.textField(passwordTextFieldStub,
                                        shouldChangeCharactersIn: NSMakeRange(0, 1),
                                        replacementString: "A")

  self.waitForExpectations(timeout: 1.0, handler: nil)
}
```

- Run the tests - red flag.
- Fix the UITextFieldDelegate Extension in the LoginViewController:

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
[Step_15_FinalCode](FinalCode/)

Next step we'll TDD the SignupViewController.

[Step 16](../000_Step_16/000_Step16_SignupViewController.md)



