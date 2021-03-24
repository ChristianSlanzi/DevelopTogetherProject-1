## Step 9: The passwordUpdated Method

- It is called when the user updates the content of the password field.
- When this method is called, the view model checks to see if the text entered represents a valid password.
- If it does, and the content of the username text field is also valid, then the view model asks the view controller to enable the Login button.
- Let's add the following tests:

```swift
fileprivate let validPassword = "D%io7AFn9Y"
fileprivate let invalidPassword = "a3$Am"


// MARK: passwordUpdated tests
extension LoginViewModelTests {
    
    func testPasswordUpdated_Calls_Validate_OnPasswordValidator() {
        let expectation = self.expectation(description: "expected validate() to be called")
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.passwordValidator = MockPasswordValidator(expectation, expectedValue: validPassword)
        
        viewModel.passwordUpdated(validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_ValidPassword_UserNameValidated_EnablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(true) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, true)
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.userNameValidated = true
        viewModel.passwordUpdated(validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_ValidPassword_UserNameNotValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.userNameValidated = false
        
        viewModel.passwordUpdated(validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testPasswordUpdated_InvalidPassword_UserNameValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.userNameValidated = true
        
        viewModel.passwordUpdated(invalidPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordUpdated_InvalidPassword_UserNameNotValidated_DisablesLoginButton_OnViewController() {
        let expectation = self.expectation(description: "expected enableLogin(false) to be called")
        mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.userNameValidated = false
        
        viewModel.passwordUpdated(invalidPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}
```

- Run the tests. Red.
- For the first test we need to mock the PasswordValidator. You can integrate the provided file:
  [MockPasswordValidator](FilesToAdd/MockPasswordValidator.swift)
- Implement the needed changes in LoginViewModel

```swift
//add variable
var passwordValidator: PasswordValidator?

//add method
func passwordUpdated(_ value: String?) {
	
  guard let value = value else { 
    view?.enableLoginButton(false) 
    return
	}
  
	let validator = self.passwordValidator ?? PasswordValidator() 	
  passwordValidated = validator.validate(value)

  if passwordValidated == false {
    view?.enableLoginButton(false) 
    return
	}

  if userNameValidated == false {
    view?.enableLoginButton(false) 
    return
	}

  view?.enableLoginButton(true) 
}
```

- Run the tests. Green.

  

  Now your project should look like this:
  [Step_9_FinalCode](FinalCode/)

  Next step we'll continue the binding:

  [Step 10](../000_Step_10/000_Step10_Binding5.md)

  

