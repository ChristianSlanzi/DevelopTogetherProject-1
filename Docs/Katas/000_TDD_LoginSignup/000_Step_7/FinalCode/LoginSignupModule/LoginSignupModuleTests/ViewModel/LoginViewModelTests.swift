//
//  LoginViewModelTests.swift
//  LoginSignupModuleTests
//
//  Created by Christian Slanzi on 22.03.21.
//

import XCTest
@testable import LoginSignupModule

class LoginViewModelTests: XCTestCase {
    
    fileprivate var mockLoginViewController: MockLoginViewController?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockLoginViewController = MockLoginViewController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInit_ValidView_InstantiatesObject() {
      let viewModel = LoginViewModel(view: mockLoginViewController!)
      XCTAssertNotNil(viewModel)
    }
    
    func testInit_ValidView_CopiesViewToIvar() {
        let viewModel = LoginViewModel(view: mockLoginViewController!)
        if let lhs = mockLoginViewController,
           let rhs = viewModel.view as? MockLoginViewController {
            XCTAssertTrue(lhs === rhs)
      }
    }

}

// MARK: performInitialViewSetup tests
extension LoginViewModelTests {
    
  func testPerformInitialViewSetup_Calls_ClearUserNameField_OnViewController() {
    let expectation = self.expectation(description: "expected clearUserNameField() to be called")
    mockLoginViewController!.expectationForClearUserNameField = expectation

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.performInitialViewSetup()

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testPerformInitialViewSetup_Calls_ClearPasswordField_OnViewController() {
    let expectation = self.expectation(description: "expected clearPasswordField() to be called")
    mockLoginViewController!.expectationForClearPasswordField = expectation

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.performInitialViewSetup()

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testPerformInitialViewSetup_DisablesLoginButton_OnViewController() {
    let expectation = self.expectation(description: "expected enableLoginButton(false) to be called")
    mockLoginViewController!.expectationForEnableLoginButton = (expectation, false)

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.performInitialViewSetup()

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }

  func testPerformInitialViewSetup_EnablesCreateAccountButton_OnViewController() {
    let expectation = self.expectation(description: "expected enableCreateAccountButton(true) to be called")
    mockLoginViewController!.expectationForCreateAccountButton = (expectation, true)

    let viewModel = LoginViewModel(view: mockLoginViewController!)
    viewModel.performInitialViewSetup()

    self.waitForExpectations(timeout: 1.0, handler: nil)
  }
}

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
