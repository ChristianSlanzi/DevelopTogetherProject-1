# Step 6: Binding ViewModel to ViewController

## The performInitialViewSetup Method

- Should be called from viewDidLoad method. Resets the ui elements.

  - clear the content of the username field
  - clear the content of the password field
  - disable the login button
  - enable the create account button

- TDD, first we write the tests:

  ```swift
  // MARK: performInitialViewSetup tests
  extension LoginViewModelTests {
      
    func testPerformInitialViewSetup_Calls_ClearUserNameField_OnViewController() {
      let expectation = self.expectation(description: "expected clearUserNameField() to be called")
      mockLoginViewController!.expectationForClearUserNameField = expectation
  
      let viewModel = LoginViewModel(view: mockLoginViewController!)
      viewModel.performInitialViewSetup()
  
      self.waitForExpectations(timeout: 1.0, handler: nil)
    }
  
    func testPerformInitialViewSetup_Calls_ClearPasswordField_OnViewController() {
      let expectation = self.expectation(description: "expected clearPasswordField() to be called")
      mockLoginViewController!.expectationForClearPasswordField = expectation
  
      let viewModel = LoginViewModel(view: mockLoginViewController!)
      viewModel.performInitialViewSetup()
  
      self.waitForExpectations(timeout: 1.0, handler: nil)
    }
  
    func testPerformInitialViewSetup_DisablesLoginButton_OnViewController() {
      let expectation = self.expectation(description: "expected enableLoginButton(false) to be called")
      mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)
  
      let viewModel = LoginViewModel(view: mockLoginViewController!)
      viewModel.performInitialViewSetup()
  
      self.waitForExpectations(timeout: 1.0, handler: nil)
    }
  
    func testPerformInitialViewSetup_EnablesCreateAccountButton_OnViewController() {
      let expectation = self.expectation(description: "expected enableCreateAccountButton(true) to be called")
      mockLoginViewController!.expectationForCreateAccountButton = (expectation, true)
  
      let viewModel = LoginViewModel(view: mockLoginViewController!)
      viewModel.performInitialViewSetup()
  
      self.waitForExpectations(timeout: 1.0, handler: nil)
    }
  }
  ```

  The performInitialViewSetup method is being called from viewDidLoad, so its completion is async. For this reason we use xctest expectations to proof its oucome.
  Add following code to the MockLoginViewController file

  ```swift
  var expectationForClearUserNameField: XCTestExpectation?
  var expectationForClearPasswordField: XCTestExpectation?
  var expectationForEnableLoginButton: (XCTestExpectation, Bool)?
  var expectationForCreateAccountButton: (XCTestExpectation, Bool)?
  var expectationForHideKeyboard: XCTestExpectation?
  
  func clearUserNameField() {
    self.expectationForClearUserNameField?.fulfill()
  }
  
  func clearPasswordField() {
    self.expectationForClearPasswordField?.fulfill()
  }
  
  func enableLoginButton(_ status: Bool) {
    if let (expectation, expectedValue) = self.expectationForEnableLoginButton {
      if status == expectedValue {
        expectation.fulfill()
      }
    }
  }
  
  func enableCreateAccountButton(_ status: Bool) {
    if let (expectation, expectedValue) = self.expectationForCreateAccountButton {
      if status == expectedValue {
        expectation.fulfill()
      }
    }
  }
  
  func hideKeyboard() {
    self.expectationForHideKeyboard?.fulfill()
  }
  ```


- We can now implement the performInitialViewSetup method in LoginViewModel

  ```swift
  func performInitialViewSetup() { 
    view?.clearUserNameField() 
    view?.clearPasswordField() 
    view?.enableLoginButton(false) 
    view?.enableCreateAccountButton(true)
    view?.hideKeyboard()
  }
  ```

- For this to work, we need to define the methods in the LoginViewControllerProtocol

  ```swift
  protocol LoginViewControllerProtocol: class {
      func clearUserNameField()
      func clearPasswordField()
      func enableLoginButton(_ status: Bool)
      func enableCreateAccountButton(_ status: Bool)
      func hideKeyboard()
  }
  ```
  
- Now we need to add the following method definitions to the LoginViewController:

  ```swift
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
  }
  ```

- Run the tests, they should be all green.

Now your project should look like this:
[Step_6_FinalCode](FinalCode/)

Next step we'll continue the binding:

[Step 7](../000_Step_7/000_Step7_Binding2.md)

