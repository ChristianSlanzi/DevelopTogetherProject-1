## Step 7: The userNameDidEndOnExit Method

- Should be called when the didEndOnExit event is received from the username text field.  When this method is called, the view model asks the view controller to dismiss the keyboard if it was visible.

  Add the following test method:

  ```swift
  // MARK: userNameDidEndOnExit tests
  extension LoginViewModelTests {
  	func testUserNameDidEndOnExit_Calls_HideKeyboard_OnViewController() { 
     	let expectation = self.expectation(description: "expected hideKeyboard() to be called") 
      mockLoginViewController!.expectationForHideKeyboard = expectation
  		let viewModel = LoginViewModel(view:mockLoginViewController!) 		
      viewModel.userNameDidEndOnExit()
  		self.waitForExpectations(timeout: 1.0, handler: nil) 
    }
  }
  ```

- Run the test - red

- Let's implement the method in the LoginViewModel

  ```swift
  func userNameDidEndOnExit() { 
    view?.hideKeyboard()
  }
  ```

- Run the test - green

## The passwordDidEndOnExit Method

- It is called when the didEndOnExit event is received from the password text field.  When this method is called, the view model asks the view controller to dismiss the keyboard if it was visible.

  Add the following test method:

```swift

// MARK: passwordDidEndOnExit tests
extension LoginViewModelTests {

  func testPasswordDidEndOnExit_Calls_HideKeyboard_OnViewController() { 
  
    let expectation = self.expectation(description: "expected hideKeyboard() to be called") 
  	mockLoginViewController!.expectationForHideKeyboard = expectation
		let viewModel = LoginViewModel(view:mockLoginViewController!) 		
    viewModel.passwordDidEndOnExit()
		self.waitForExpectations(timeout: 1.0, handler: nil) 
  }
}

```

- Run the test - red

- Let's implement the method in the LoginViewModel

  ```swift
  func passwordDidEndOnExit() { 
    view?.hideKeyboard()
  }
  ```

- Run the test - green

Now your project should look like this:
[Step_7_FinalCode](FinalCode/)

Next step we'll continue the binding:

[Step 8](../000_Step_8/000_Step8_Binding3.md)

