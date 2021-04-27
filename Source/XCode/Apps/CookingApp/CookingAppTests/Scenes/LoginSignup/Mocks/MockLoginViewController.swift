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
    
    func clearUserNameField() {
        self.expectationForClearUserNameField?.fulfill()
    }
}
