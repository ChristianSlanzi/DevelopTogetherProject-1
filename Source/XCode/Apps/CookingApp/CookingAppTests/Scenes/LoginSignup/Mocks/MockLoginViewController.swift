//
//  MockLoginViewController.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import XCTest

@testable import CookingApp

class MockLoginViewController: LoginViewControllerProtocol {

    var expectationForClearUserNameField: XCTestExpectation?
    var expectationForClearPasswordField: XCTestExpectation?
    var expectationForEnableLoginButton: (XCTestExpectation, Bool)?
    
    func clearUserNameField() {
        self.expectationForClearUserNameField?.fulfill()
    }
    
    func clearPasswordField() {
        self.expectationForClearPasswordField?.fulfill()
    }
    
    func enableLoginButton(_ status: Bool) {
        if let (expectation, expectedValue) = self.expectationForEnableLoginButton {
            if status == expectedValue {
                expectation.fulfill()
            }
        }
    }
}
