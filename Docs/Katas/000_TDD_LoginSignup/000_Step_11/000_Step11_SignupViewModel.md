## The SignupViewModel

- The process of building the SignupViewModel with TDD is equivalent of what we have done with the LoginViewModel. All the files are then provided for integration.

- Add first the SignupViewModelTests.swift under Tests/ViewModel:

  

- The tests won't compile. We need first the mocked MockSignupViewController. Add it under Tests/Mocks:
  [MockSignupViewController](FilesToAdd/MockSignupViewController.swift)

- The mocked view controller requires its SignupViewControllerProtocol: Add it under Production/Protocols:
  [SignupViewControllerProtocol](FilesToAdd/SignupViewControllerProtocol.swift)

- Finally add the SignupViewModel class:
  [SignupViewModel](FilesToAdd/SignupViewModel.swift)

- The ViewModel requires its Controller class:
  [SignupController](FilesToAdd/SignupController.swift)

- Build and run the tests. We still miss a couple of mocks:
  [MockEmailAddressValidator](FilesToAdd/MockEmailAddressValidator.swift)
[MockSignupController](FilesToAdd/MockSignupController.swift)
  
- Run the tests again, they should now go green!

  

Now your project should look like this:
[Step_11_FinalCode](FinalCode/)

Next step we'll bind the ViewController to the ViewModel.

[Step 12](../000_Step_11/000_Step11_SignupViewModel.md)



