# Step 0: Removing fixed XCode composition

When you create a new app, XCode creates a project where the Scene Delegate automatically loads the initial controller that it finds in the Main.Storyboard. But in this way the app composition is fixed at design time.

You can break this default behavior by modifying the settings in the Info.plist and in the App.xcodeproj.

- Open the workspace and select the App project.
- Remove the entry "Storyboard name" - "Main" contained under 
  "Application Scene Manifest" 
           -> Scene Configuration
                    -> Application Session Role
                            -> Item 0 (Default Configuration)

If you launch the app now, only a black screen should appear on your device/simulator. This means we broke the fixed composition! In fact, the screen is black because the App loader is not finding anymore its entry point. Now:

- Set the identifiers "LoginViewController" and "SignupViewController" in the main storyboard for the two view controllers
- Replace the SceneDelegate::scene(_ scene:, willConnectTo session:, options connectionOptions:) method with following implementation:

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
  guard let windowScene = (scene as? UIWindowScene) else { return }

  window = UIWindow(frame: windowScene.coordinateSpace.bounds)
  window?.windowScene = windowScene

  let storyboard = UIStoryboard(name: "Main", bundle: .main)
  let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
  window?.rootViewController = controller

  window?.makeKeyAndVisible()
}
```

- Run the App. The LoginViewController appears and the app works as before. But now we have control over the app composition. We could decide for example to inject a different view model implementation, the MockedLoginViewModel, in the controller. Or we could start with another controller, we could for example start with the SignupViewController. This allows us to change the composition of the app, to test different flows.
- 

Now your project should look like this:
[Step_0_FinalCode](FinalCode/)

Next step we'll add the AppDependencies class (our composition root):

[Step 1](../002_Step_1/002_Step1_AppDependencies.md)

