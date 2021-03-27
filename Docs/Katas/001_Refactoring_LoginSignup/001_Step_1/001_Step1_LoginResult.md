# Step 1: Login outcome

- We should show a message after the user has pressed the login button.

- Add the following method to LoginViewControllerProtocol:

  ```swift
  func showLoginResult(_ result: Bool)
  ```

  

- Now we are required to implement the method in the classes that adopted the protocol. Let's start with the tests. Add the method to the MockLoginViewController class:

```swift
func showLoginResult(_ result: Bool) {
        
}
```



- For the mock, we don't need to make anything.
- Add now the following method implementation to the real LoginViewController:

```swift
func showLoginResult(_ result: Bool) {
  let alert = UIAlertController(title: result ? "Congratulations" : "Error",
                                message: result ? "Login was successful" : "Username or Password not valid",
                                preferredStyle: UIAlertController.Style.alert)
  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
  self.present(alert, animated: true, completion: nil)
}
```



- Now the method needs to be called from the login view model. Change the LoginViewModel's loginResult method to be as:

```swift
extension LoginViewModel: LoginControllerDelegate {
    
    func loginResult(result: Bool) {
        // do someting with the result,
        // perhaps segue to a different screen of the app.
        
        // we show an alert as a dummy implementation
        view?.showLoginResult(result)
    }
    
}
```

- Run the app and test the login method.
- Try with any possible username and password of your choice, you should get an error that the login credentials are not valid, i.e. there's not such account in the system.
- Try the only valid credentials, username: "Alibaba", password: "Sesamo123". These credentials are ATM hardcoded in the LoginController, the compoment where you would inject your real authorization networking logic. Using them you get now a message that the login was successful.

Now your project should look like this:
[Step_1_FinalCode](FinalCode/)

Next step we'll remove the dependecy from NSObject:

[Step 2](../001_Step_2/001_Step2_RemoveObjC.md)

