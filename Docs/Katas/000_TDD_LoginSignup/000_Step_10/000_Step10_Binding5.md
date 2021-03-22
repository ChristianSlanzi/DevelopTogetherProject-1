## The login Method

- It is called when the user taps on the Login button.
- When this method is called, the view model gather the entered username and password to create a LoginModel object.
- The LoginModel object is passed to a LoginController that encapsulates the logic to authenticate thee user.
- Let's add the following tests:

```swift
// MARK: login tests
extension LoginViewModelTests {
    
    func testLogin_ValidParameters_Calls_doLogin_OnLoginController() {
        let expectation = self.expectation(description: "expected doLogin() to be called")
        
        let mockLoginController = MockLoginController(expectation, 
                                                      expectedUserName: validUserName, 
                                                      expectedPassword: validPassword)
        mockLoginController.shouldReturnTrueOnLogin = true
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.loginController = mockLoginController
        mockLoginController.loginControllerDelegate = viewModel
        
        viewModel.login(userName: validUserName, password: validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func testLogin_ValidParameters_Calls_doLoginWithExpectedUserName_OnLoginController() {
        let expectation = self.expectation(description: "expected doLogin() to be called")
        
        let mockLoginController = MockLoginController(expectation, 
                                                      expectedUserName: validUserName, 
                                                      expectedPassword: validPassword)
        mockLoginController.shouldReturnTrueOnLogin = true
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.loginController = mockLoginController
        mockLoginController.loginControllerDelegate = viewModel
        
        viewModel.login(userName: validUserName, password: validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    
    func testLogin_ValidParameters_Calls_doLoginWithExpectedPassword_OnLoginController() {
        let expectation = self.expectation(description: "expected doLogin() to be called")
        
        let mockLoginController = MockLoginController(expectation, 
                                                      expectedUserName: validUserName, 
                                                      expectedPassword: validPassword)
        mockLoginController.shouldReturnTrueOnLogin = true
        
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        viewModel.loginController = mockLoginController
        mockLoginController.loginControllerDelegate = viewModel
        
        viewModel.login(userName: validUserName, password: validPassword)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}
```

- Run the tests. Red.
- Let's create the LoginController class under the Controllers group.

```swift
import Foundation

protocol LoginControllerDelegate: class {
    func loginResult(result: Bool)
}

class LoginController: NSObject {
    let dummyUsername = "Alibaba"
    let dummyPassword = "Sesamo123"
   
    weak var loginControllerDelegate: LoginControllerDelegate?

    init(delegate: LoginControllerDelegate?) {
        self.loginControllerDelegate = delegate
        super.init()
    }
    
    func doLogin(model: LoginModel) {
        let userName = model.userName
        let password = model.password
        
        if ((userName.compare(dummyUsername) == .orderedSame)
                && (password.compare(dummyPassword) == .orderedSame)) {
            loginControllerDelegate?.loginResult(result: true)
            return
        }
        
        loginControllerDelegate?.loginResult(result: false)
    }
    
}
```

- But when we want to test the ViewModel against the login method, we should be able to do it in isolation. So we need to mock the LoginController. Create a MockLoginController.swift under Tests/Mocks.

```swift
import Foundation
import XCTest
@testable import LoginSignupModule

class MockLoginController: LoginController {
    
    private var expectation: XCTestExpectation?
    private var expectedUserName: String?
    private var expectedPassword: String?
    
    var shouldReturnTrueOnLogin: Bool
    
    init(_ expectation: XCTestExpectation, 
         expectedUserName: String,
         expectedPassword: String) {
        
        self.expectation = expectation
        self.expectedUserName = expectedUserName
        self.expectedPassword = expectedPassword
        self.shouldReturnTrueOnLogin = false
        
        super.init(delegate: nil)
    }
    
    override func doLogin(model: LoginModel) {
        
        if let expectation = self.expectation,
           let expectedUserName = self.expectedUserName,
           let expectedPassword = expectedPassword {
            if ((model.userName.compare(expectedUserName) == .orderedSame)
                    && (model.password.compare(expectedPassword) == .orderedSame)) {
                expectation.fulfill()
            }
        }
        loginControllerDelegate?.loginResult(result: shouldReturnTrueOnLogin)
    }
}
```

- Now the LoginViewModel class needs to be updated 

```swift
// add a variable declaration for the LoginController
var loginController: LoginController?

// add the login method
func login(userName: String?, password: String?) {
  
  let controller = self.loginController ?? LoginController(delegate: self)

  if let userName = userName,
  	let password = password,
  	let model = LoginModel(userName: userName, password: password) {
    	controller.doLogin(model: model)
  }
}


// outside the class,
// let's implement the LoginControllerDelegate
extension LoginViewModel: LoginControllerDelegate {
    
    func loginResult(result: Bool) {
        // do someting with the result,
        // perhaps segue to a different screen of the app.
    }
}
```

- Run the tests - now they should be all green.

  

Now your project should look like this:
[Step_10_FinalCode](FinalCode/)

Next step we'll implement the SignupViewModel class.

[Step 11](../000_Step_11/000_Step11_SignupViewModel.md)



