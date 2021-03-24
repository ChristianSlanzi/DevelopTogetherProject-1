## Step 8: The userNameUpdated Method

- It is called when the user updates the content of the username field.
- When this method is called, the view model checks to see if the text entered represents a valid username.
- If it does, and the content of the password text field is also valid, then the view model asks the view controller to enable the Login button.
- Let's add the following tests:

```swift
fileprivate var validUserName = "abcdefghij" 
fileprivate var invalidUserName = "a"


// MARK: userNameUpdated tests
extension LoginViewModelTests {
  func testUserNameUpdated_Calls_Validate_OnUserNameValidator() {
    let expectation = self.expectation(description: "expected validate() to be called")

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.userNameValidator = MockUserNameValidator(expectation, 
                                                        expectedValue: validUserName)

    viewModel.userNameUpdated(validUserName)

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testUserNameUpdated_ValidUserName_PasswordValidated_EnablesLoginButton_OnViewController() {
    let expectation = self.expectation(description: "expected enableLogin(true) to be called")
    mockLoginViewController!.expectationForEnableLoginButton = (expectation, true)

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.passwordValidated = true
    viewModel.userNameUpdated(validUserName)

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testUserNameUpdated_ValidUserName_PasswordNotValidated_DisablesLoginButton_OnViewController() {
    let expectation = self.expectation(description: "expected enableLogin(false) to be called")
    mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.passwordValidated = false

    viewModel.userNameUpdated(validUserName)

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testUserNameUpdated_InvalidUserName_PasswordValidated_DisablesLoginButton_OnViewController() {
    let expectation = self.expectation(description: "expected enableLogin(false) to be called")
    mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.passwordValidated = true

    viewModel.userNameUpdated(invalidUserName)

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testUserNameUpdated_InvalidUserName_PasswordNotValidated_DisablesLoginButton_OnViewController() {
    let expectation = self.expectation(description: "expected enableLogin(false) to be called")
    mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.passwordValidated = false

    viewModel.userNameUpdated(invalidUserName)

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
}
```

- For the first test we use a mocked version of the UserNameValidator, so that we can test the LoginViewModel in isolation. Add the provided MockUserNameValidator under Mocks group:
  [MockUserNameValidator](FilesToAdd/MockUserNameValidator.swift)
- Implement the needed changes in LoginViewModel

```swift
var userNameValidator: UserNameValidator?
var userNameValidated: Bool
var passwordValidated: Bool

init(view: LoginViewControllerProtocol) { 			
  self.userNameValidated = false 		
  self.passwordValidated = false
  super.init()
  self.view = view 
}

func userNameUpdated(_ value: String?) {
	guard let value = value else { 				
    view?.enableLoginButton(false) 
    return
	}

  let validator = self.userNameValidator ?? UserNameValidator() 
  userNameValidated = validator.validate(value)

  if userNameValidated == false { 
    view?.enableLoginButton(false) 
    return
	}

  if passwordValidated == false { 
    view?.enableLoginButton(false) 
    return
	}
  
	view?.enableLoginButton(true) 
}
```

- Run the tests.

Now your project should look like this:
[Step_8_FinalCode](FinalCode/)

Next step we'll continue the binding:

[Step 9](../000_Step_9/000_Step9_Binding4.md)

