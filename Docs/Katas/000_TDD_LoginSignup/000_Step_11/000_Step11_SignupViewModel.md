## The SignupViewModel

- The process of building the SignupViewModel with TDD is equivalent of what we have done with the LoginViewModel. All the files are then provided for integration.

- Add first the SignupViewModelTests.swift under Tests/ViewModel:

  

- The tests won't compile. We need first the mocked MockSignupViewController. Add it under Tests/Mocks:
  

- The mocked view controller requires its SignupViewControllerProtocol: Add it under Production/Protocols:
  

- Finally add the SignupViewModel class:
  SignupViewModel

- The ViewModel requires its Controller class:
  

- Build and run the tests. We still miss a couple of mocks:
  MockEmailAddressValidator

  MockSignupController

- Run the tests again, they should now go green!

  

Now your project should look like this:
[Step_10_FinalCode](FinalCode/)

Next step we'll implement the SignupViewModel class.

[Step 11](../000_Step_11/000_Step11_SignupViewModel.md)



