# Step 1: Composing the SignupViewController

We should now compose the creation of the SignupViewController in the Composition Root. The first step is easy. 

- Add the following method to the AppDependencies:

```swift
private func createSignupViewController() -> SignupViewController {
  let storyboard = UIStoryboard(name: "Main", bundle: .main)
  let controller = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController

  let viewModel = SignupViewModel(view: controller)
  controller.viewModel = viewModel

  return controller
}
```

- The signup view controller should be presented when the user taps on the Create Account button in the LoginViewController.
- At the moment this happens thanks to the segue between the two view controllers in the storyboard.
- We want to remove the segue and perform the composition programmatically in our composition root. 
- Delete the segue and also the performSegue instruction contained in the LoginViewController::createAccount method otherwise the app'll crash when the Create Account button gets tapped.
- Add the following code to the AppDependencies file:

```swift
protocol LoginRouting: class {
    func routeToSignupViewController()
}

extension AppDependencies: LoginRouting {
    func routeToSignupViewController() {
        window?.rootViewController?.present(createSignupViewController(), animated: true)
    }
}
```

- Here we implemented a simple Routing protocol. We'll come back to the concept of Routing in another Kata, for the moment I'll just use this mechanism as a communication tool between the LoginViewController and the CompositionRoot.
- We need to inject the protocol in the LoginViewController. Add the following code to its class:

```swift
weak var routing: LoginRouting?

@IBAction func createAccount(_ sender: Any) {
  routing?.routeToSignupViewController()
}
```

- Now we can modify the creation of the LoginViewController.

```swift
private func createLoginViewController() -> LoginViewController {
  let storyboard = UIStoryboard(name: "Main", bundle: .main)
  let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

  let viewModel = LoginViewModel(view: controller)
  controller.viewModel = viewModel
  controller.routing = self

  return controller
}
```

- We injected the AppDependencies in the LoginViewController as LoginRoutinProtocol, so that the view controller will know only about the routeToSignupViewController method.

- Run the app and click on the CreateAccount button. It will transition to the SignupViewController.
- Add a new method declaration to the LoginRouting protocol:

```swift
func routeToMainViewController()
```

- Implement the method in the extension:

```swift
func routeToMainViewController() {
 setRootViewController(createMainViewController(), window: window)
}
```

- Now you can also call this method from the login:

```swift
public func login() {
  var isUserLoggedIn = false

  //if we have credentials
  if isUserLoggedIn {
    routeToMainViewController()
  } else {
    setRootViewController(createLoginViewController(), window: window)
  }
}
```

- And let's modify the showLoginResult method:

```swift
func showLoginResult(_ result: Bool) {
        
  let alert = UIAlertController(title: result ? "Congratulations" : "Error",
                                message: result ? "Login was successful" : "Username or Password not valid",
                                preferredStyle: UIAlertController.Style.alert)
  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
  self.present(alert, animated: true) {
    if result == true {
      self.routing?.routeToMainViewController()
    }
  }
}
```

- We added a completion closure to alert presentation. If the result of the login process was succesful, we route to the main view controller.
- Run the app and test the login. ("Alibaba", "Sesamo123")
- NB. If you want to be sure that it works, as we don't have any interface in the main view controller, sets its view background color to yellow in the viewDidLoad method. 



Now your project should look like this:
[Step_2_FinalCode](FinalCode/)