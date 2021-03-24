//
//  LoginViewControllerTests.swift
//  LoginSignupModuleTests
//

import XCTest
@testable import LoginSignupModule

class LoginViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
    func testViewDidLoad_Calls_PerformInitialSetup_OnViewModel() {
        let expectation = self.expectation(description: "expected performInitialViewSetup() to be called")
        let loginViewController = LoginViewController()
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.performInitialViewSetupExpectation = expectation
        loginViewController.viewModel = viewModel
        loginViewController.viewDidLoad()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testUserNameDidEndOnExit_Calls_UserNameDidEndOnExit_OnViewModel() {
        
        let expectation = self.expectation(description: "expected userNameDidEndOnExit() to be called")
        
        let loginViewController = LoginViewController()
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.userNameDidEndOnExitExpectation = expectation
        
        loginViewController.viewModel = viewModel
        
        loginViewController.userNameDidEndOnExit(self)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testPasswordDidEndOnExit_Calls_PasswordDidEndOnExit_OnViewModel() {
        
        let expectation = self.expectation(description: "expected passwordDidEndOnExit() to be called")
        
        let loginViewController = LoginViewController()
        
        let viewModel = MockLoginViewModel(view: loginViewController)
        viewModel.passwordDidEndOnExitExpectation = expectation
        
        loginViewController.viewModel = viewModel
        
        loginViewController.passwordDidEndOnExit(self)
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

}
