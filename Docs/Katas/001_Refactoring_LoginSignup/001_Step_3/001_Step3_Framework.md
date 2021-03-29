# Step 3: Move logic in a framework

- We are going to split the code in App and Modules. The Model and BusinessLogic of the LoginSignup will be moved in a indipendent framework.

- Let's build the new structure from scratch.

- Create a new main project, the App

- Separate UnitTests from UITests as in the previous step

- Replace the new Main.Storyboard with our version.
  Xxx

- If you run the app now, it will crash because it can't load the LoginViewController. Let's add it under a new View group. Add also the SignupViewController.

- We can't still build because we miss the ViewModels and the Protocols. Let's add them to the Project.

- Now we miss the BusinessLogic and the Models. Let's make a new project for that in a separate folder named LoginSignupModule. Choose Framework as project type.

- Close both projects and create a solution on top of them. I'll call the solution "App".

- The solution is empty. Add the App and LoginSignupModule projects to it.

- Add Model and Controllers groups to the LoginSignupModule and add the respective files to them from our previous implementation.
  Xxx

- Now the LoginSignupModule is able to build, but the App still not because it requires to import the framework.

- Move to the LoginViewModel and add the required import statement

  ```swift
  import LoginSignupModule 
  ```

- The compiler won't still be able to find the classes, because they are internal to the framework. Let's make them public.

- The initializers need also to be public. Add a public empty initiliazers in the classes without explict init method (implicit default initializers are internal per default) or the public modifier to the other ones.

- The validate methods and doLogin, doSignup need also to be public.

- Move the tests respectively to App and LoginSignupModule.

- Run the tests. They are all still green. We can commit our changes in safety.



Now your project should look like this:
[Step_3_FinalCode](FinalCode/)