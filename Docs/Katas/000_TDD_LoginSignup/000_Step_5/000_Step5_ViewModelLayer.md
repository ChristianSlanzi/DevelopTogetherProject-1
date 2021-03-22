# Step 5: Build the ViewModel layer

## The LoginViewModel class

- Let's TDD the LoginViewModel class. Create a unit test called LoginViewModelTests under LoginSignupModuleTests/ViewModel group. 

- Import the production Module

  ```swift
  @testable import LoginSignupModule
  ```

- Let's start testing the instantiation of the viewmodel. Add the following code:

  ```swift
  fileprivate var mockLoginViewController: MockLoginViewController?
  
  override func setUpWithError() throws {
     mockLoginViewController = MockLoginViewController()
  }
  
  func testInit_ValidView_InstantiatesObject() {
    let viewModel = LoginViewModel(view: mockLoginViewController!) 			
    XCTAssertNotNil(viewModel)
  }
  ```

  Following the MVVM UI Architecture, the viewmodel takes a weak reference of the view. As we do want to test the viewmodel in isolation, we need to pass a mocked version of our view. Using paradigms like as Dependency Injection, Dependency Inversion and Protocols, the viewmodel doesn't know about the concrete implementation of the view, but just about its protocol.

- Create the LoginViewModel class in production code under LoginSignupModule/ViewModel group.

  ```swift
  import Foundation
  class LoginViewModel: NSObject {
    weak var view: LoginViewControllerProtocol?
  
    init(view: LoginViewControllerProtocol) { 
      super.init()
  		self.view = view 
    }
  }
  ```

- Create the LoginViewControllerProtocol file in production code under /Protocols group.

  ```swift
  protocol LoginViewControllerProtocol: class {
  }
  ```

- Create the MockLoginViewController class in test code under /Mocks group.

  ```swift
  import UIKit
  import XCTest
  @testable import LoginSignupModule
  
  class MockLoginViewController: LoginViewControllerProtocol {
  }
  ```

- Run the test, it'll pass.

- add test method to verify view var is copied in the viewmodel, also passing:

  ```swift
  func testInit_ValidView_CopiesViewToIvar() {
  	let viewModel = LoginViewModel(view: mockLoginViewController!)
  	if let lhs = mockLoginViewController, 
    	 let rhs = viewModel.view as? MockLoginViewController {
  		XCTAssertTrue(lhs === rhs) 
    }
  }
  ```

Now your project should look like this:
[Step_5_FinalCode](FinalCode/)

Next step we'll bind the ViewModel to the ViewController:

[Step 6](../000_Step_6/000_Step6_Binding1.md)



