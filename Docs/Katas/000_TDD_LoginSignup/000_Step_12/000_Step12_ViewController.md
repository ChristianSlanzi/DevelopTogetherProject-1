## Binding the ViewController to the ViewModel

- Let's start with the Login. Create a UnitTest with the name LoginViewControllerTests under Tests/View group. Import the production code.

```swift
@testable import LoginSignupModule
```

- Add the following test method:

```swift
func testViewDidLoad_Calls_PerformInitialSetup_OnViewModel() {
  let expectation = self.expectation(description: "expected performInitialViewSetup() to be called")
  let loginViewController = LoginViewController()
  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.performInitialViewSetupExpectation = expectation
  loginViewController.viewModel = viewModel
  loginViewController.viewDidLoad()
  self.waitForExpectations(timeout: 1.0, handler: nil)
}
```

- The test won't compile - Red flag.
- To test the ViewController in isolation we need to inject a mocked view model. Add the MockLoginViewModel class under Tests/ViewModel:

```swift
import Foundation
import XCTest
@testable import LoginSignupModule

class MockLoginViewModel: LoginViewModel {
    
    var performInitialViewSetupExpectation: XCTestExpectation?
    var userNameDidEndOnExitExpectation: XCTestExpectation?
    var passwordDidEndOnExitExpectation: XCTestExpectation?
    var userNameUpdatedExpectation: (XCTestExpectation, expectedValue: String)?
    var passwordUpdatedExpectation: (XCTestExpectation, expectedValue: String)?
    var loginExpectation: (XCTestExpectation, expectedUserName: String, expectedPassword: String)?
    
    override func performInitialViewSetup() {
        performInitialViewSetupExpectation?.fulfill()
    }
    
    override func userNameDidEndOnExit() {
        userNameDidEndOnExitExpectation?.fulfill()
    }
    
    override func passwordDidEndOnExit() {
        passwordDidEndOnExitExpectation?.fulfill()
    }
    
    override func userNameUpdated(_ value: String?) {
        if let (expectation, expectedValue) = self.userNameUpdatedExpectation,
            let value = value {
            if value.compare(expectedValue) == .orderedSame {
                expectation.fulfill()
            }
        }
    }
    
    override func passwordUpdated(_ value: String?) {
        if let (expectation, expectedValue) = self.passwordUpdatedExpectation,
            let value = value {
            if value.compare(expectedValue) == .orderedSame {
                expectation.fulfill()
            }
        }
    }
    
    override func login(userName: String?, password: String?) {
        
        if let (expectation, expectedUserName, expectedPassword) = self.loginExpectation,
            let userName = userName,
            let password = password {
            if ((userName.compare(expectedUserName) == .orderedSame) &&
                (password.compare(expectedPassword) == .orderedSame)) {
                
                expectation.fulfill()
            }
        }
    }
    
}
```

- The view controller now needs an instance of the view model. We add it as optional variable instance so that we are able to inject it from outside for test purposes or to instantiate it internally for production:

```swift
var viewModel: LoginViewModel?

override func viewDidLoad() {
  super.viewDidLoad()

  userNameTextField?.delegate = self
  passwordTextField?.delegate = self
  
  if self.viewModel == nil {
    self.viewModel = LoginViewModel(view: self)
  }

  self.viewModel?.performInitialViewSetup()
}
```

- Run the tests - green!

Now your project should look like this:
[Step_12_FinalCode](FinalCode/)

Next step we'll bind the other events.

[Step 13](../000_Step_13/000_Step13_BindingEvents.md)



