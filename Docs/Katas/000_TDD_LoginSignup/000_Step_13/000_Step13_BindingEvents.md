## Step 13: Binding the ViewController events

- The next step is to test that the view model's events are respectively called by view controller events. The first case will be to test the userNameDidEndOnExit method:

```swift
func testUserNameDidEndOnExit_Calls_UserNameDidEndOnExit_OnViewModel() {
        
  let expectation = self.expectation(description: "expected userNameDidEndOnExit() to be called")

  let loginViewController = LoginViewController()

  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.userNameDidEndOnExitExpectation = expectation

  loginViewController.viewModel = viewModel

  loginViewController.userNameDidEndOnExit(self)

  self.waitForExpectations(timeout: 1.0, handler: nil)
}
```

- Run the tests - red flag.
- Call the method on the view model:

```swift
@IBAction func userNameDidEndOnExit(_ sender: Any) {
  viewModel?.userNameDidEndOnExit()
}
```

- Run the tests - green!
- Add a new test for the passwordDidEndOnExit method:

```swift
func testPasswordDidEndOnExit_Calls_PasswordDidEndOnExit_OnViewModel() {
        
  let expectation = self.expectation(description: "expected passwordDidEndOnExit() to be called")

  let loginViewController = LoginViewController()

  let viewModel = MockLoginViewModel(view: loginViewController)
  viewModel.passwordDidEndOnExitExpectation = expectation

  loginViewController.viewModel = viewModel

  loginViewController.passwordDidEndOnExit(self)

  self.waitForExpectations(timeout: 1.0, handler: nil)
}
```

- Run the test - red
- Call the method on the View Model:

```swift
@IBAction func passwordDidEndOnExit(_ sender: Any) {
  viewModel?.passwordDidEndOnExit()
}
```

- Run the test - green!

Now your project should look like this:
[Step_13_FinalCode](FinalCode/)

Next step we'll bind the login call.

[Step 15](../000_Step_15/000_Step15_BindingLogin.md)



