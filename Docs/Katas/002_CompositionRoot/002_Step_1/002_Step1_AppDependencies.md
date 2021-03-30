# Step 1: Composition Root

Let's create our composition root.

- Createa new group named "Main" in the App project.
- Add in this group a new file named AppDependencies.swift and add the following code 

```swift
import UIKit

class AppDependencies {
    
  static let shared = AppDependencies()

  private var window: UIWindow?

  private init() {
    configureDependencies()
  }

  private func configureDependencies() {

  }

  public func setScene(_ scene: UIScene) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene

    window?.makeKeyAndVisible()
  }
}
```

- The AppDependencies class is a singleton. It's a design choice. You might want to remove its static shared instance and have a public init method. We'll decide later what to do.
- The method configureDependencies is intended to initialize the CompositionRoot with system dependencies like as the networking service, the database service and so on. For now we'll leave it empty.
- the public method setScene takes a UIScene and creates a UIWindow. Let's replace the scene willConnectTo method in the SceneDelegate

```swift
var window: UIWindow?
var appDependencies = AppDependencies.shared

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

  appDependencies.setScene(scene)
}
```

- Run the app. It'll show a black screen again because we are not yet setting the root controller on the window.
- Add following methods to the AppDependencies class

```swift
private func setRootViewController(_ viewController: UIViewController, window: UIWindow?) {
  window?.rootViewController = viewController
}

private func createLoginViewController() -> LoginViewController {
  let storyboard = UIStoryboard(name: "Main", bundle: .main)
  let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
  return controller
}

public func login() {
  setRootViewController(createLoginViewController(), window: window)
}
```

- Now we are able to show the LoginViewController at app start.

```swift
func scene(_ scene: UIScene, 
           willConnectTo session: UISceneSession, 
           options connectionOptions: UIScene.ConnectionOptions) {   
  appDependencies.setScene(scene)
  appDependencies.login()
}
```

- The AppDependencies class is the root of the app composition. Here we compose the app in many different ways with easily changes. Add the following code:

```swift
private func createMainViewController() -> UIViewController {
  return ViewController()
}

public func login() {
  var isUserLoggedIn = false

  //if we have credentials
  if isUserLoggedIn {
    setRootViewController(createMainViewController(), window: window)
  } else {
    setRootViewController(createLoginViewController(), window: window)
  }
}

public func logout() {
  //remove credentials

  //call login
  setRootViewController(createLoginViewController(), window: window)
}
```

- In the login method we could test if the user was already logged in and its credentials are saved, then proceed to the main view controller. Otherwise we should land to the login view controller. Run the app again, then change the hardcoded value of isUserLoggedIn to true and run once more.
- If we are logged in, we could have a button in the main view controller that lets the user to logout and get back to LoginViewController. The button should call the logout method in the composition root.
- In the composition root you do the whole composition of the app and this is the place where you inject the dependencies. For example, let's inject the viewModel into the view controller. Get back at the AppDependencies and change the createLoginViewController method:

```swift
private func createLoginViewController() -> LoginViewController {
  let storyboard = UIStoryboard(name: "Main", bundle: .main)
  let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

  let viewModel = LoginViewModel(view: controller)
  controller.viewModel = viewModel

  return controller
}
```

- We are creating a login view model externally and injecting it in the view controller. We could have for example different versions of the view model and inject one version of them with a run time choice.

Now your project should look like this:
[Step_1_FinalCode](FinalCode/)

Next step we'll extract the SignupViewController creation and routing:

[Step 2](../002_Step_2/002_Step2_SignupViewController.md)

