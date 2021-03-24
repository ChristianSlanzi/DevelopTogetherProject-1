## Step 14: Binding the login method

- We are now ready to test the view controller login method. Add the following test cases:

```swift
func testLogin_ValidUserNameAndPassword_Calls_Login_OnViewModel_WithExpectedUserName() {
        
  let expectation = self.expectation(description: "expected login() to be called")

  let userNameTextFieldStub = UITextFieldStub(text: validUserName)
  let passwordTextFieldStub = UITextFieldStub(text: "")

  let loginViewController = LoginViewController()
  loginViewController.userNameTextField = userNameTextFieldStub
  loginViewController.passwordTextField = passwordTextFieldStub

  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.loginExpectation = (expectation,
                                expectedUserName: validUserName,
                                expectedPassword: "")

  loginViewController.viewModel = viewModel

  loginViewController.login(self)

  self.waitForExpectations(timeout: 1.0, handler: nil)
}
    
func testLogin_ValidUserNameAndPassword_Calls_Login_OnViewModel_WithExpectedPassword() {
        
  let expectation = self.expectation(description: "expected login() to be called")

  let userNameTextFieldStub = UITextFieldStub(text: "")
  let passwordTextFieldStub = UITextFieldStub(text: validPassword)

  let loginViewController = LoginViewController()
  loginViewController.userNameTextField = userNameTextFieldStub
  loginViewController.passwordTextField = passwordTextFieldStub

  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.loginExpectation = (expectation,
                                expectedUserName: "",
                                expectedPassword: validPassword)

  loginViewController.viewModel = viewModel

  loginViewController.login(self)

  self.waitForExpectations(timeout: 1.0, handler: nil)
}
```

- Tests won't compile - red flag.
- Again, to test in isolation, we want to provide stub versions of the text fields. 
- Create a UITextFieldStub class under Tests/Stubs:

```swift
import UIKit

class UITextFieldStub: UITextField {
	init(text: String) { 
    super.init(frame: CGRect.zero) 
    super.text = text
	}
	required init?(coder aDecoder: NSCoder) { 
    super.init(coder: aDecoder)
	} 
}
```

- Add now the missing help variables to the LoginViewControllerTests class:

```swift
fileprivate var validUserName = "abcdefghij" 
fileprivate let validPassword = "D%io7AFn9Y"
```

- Run the tests - still red! We need now to call the login method on the view model from the LoginViewController:

```swift
@IBAction func login(_ sender: Any) {
  viewModel?.login(userName: userNameTextField.text,
                   password: passwordTextField.text)
}
```

- Run the tests - finally green!
  

Now your project should look like this:
[Step_14_FinalCode](FinalCode/)

Next step we'll bind the login call.

[Step 15](../000_Step_15/000_Step15_TextFieldsTests.md)



