//
//  MockLoginController.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import XCTest
import LoginSignupModule

class MockLoginController: LoginController {
    
    private var expectation: XCTestExpectation?
    private var expectedUserName: String?
    private var expectedPassword: String?
    
    var shouldReturnTrueOnLogin: Bool
    
    init(_ expectation: XCTestExpectation,
         expectedUserName: String,
         expectedPassword: String) {
        
        self.expectation = expectation
        self.expectedUserName = expectedUserName
        self.expectedPassword = expectedPassword
        self.shouldReturnTrueOnLogin = false
        
        super.init(delegate: nil)
    }
    
    override func doLogin(model: LoginModel) {
        
        if let expectation = self.expectation,
           let expectedUserName = self.expectedUserName,
           let expectedPassword = expectedPassword {
            if ((model.getUsername().compare(expectedUserName) == .orderedSame)
                    && (model.getPassword().compare(expectedPassword) == .orderedSame)) {
                expectation.fulfill()
            }
        }
        loginControllerDelegate?.loginResult(result: shouldReturnTrueOnLogin, error: nil)
    }
}
