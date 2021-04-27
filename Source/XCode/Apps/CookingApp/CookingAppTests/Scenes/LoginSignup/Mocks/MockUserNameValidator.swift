//
//  MockUserNameValidator.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import Foundation
import XCTest
import LoginSignupModule
@testable import CookingApp

class MockUserNameValidator: UserNameValidator {

    private var expectation: XCTestExpectation?
    private var expectedValue: String?
    
    init(_ expectation: XCTestExpectation, expectedValue: String) {
        self.expectation = expectation
        self.expectedValue = expectedValue
        super.init()
    }
    
    override func validate(_ value: String) -> Bool {
        
        if let expectation = self.expectation,
            let expectedValue = self.expectedValue {
            if value.compare(expectedValue) == .orderedSame {
                expectation.fulfill()
            }
        }
        
        return super.validate(value)
    }

    
}
