//
//  MockSignupController.swift
//  LoginSignupModuleTest
//

import Foundation
import XCTest
@testable import LoginSignupModule

class MockSignupController: SignupController {
    
    private var expectation: XCTestExpectation?
    private var expectedUserName: String?
    private var expectedPassword: String?
    private var expectedEmailAddress: String?
    
    var shouldReturnTrueOnSignup: Bool
    
    init(_ expectation: XCTestExpectation,
         expectedUserName: String,
         expectedPassword: String,
         expectedEmailAddress: String) {
        
        self.expectation = expectation
        self.expectedUserName = expectedUserName
        self.expectedPassword = expectedPassword
        self.expectedEmailAddress = expectedEmailAddress
        
        self.shouldReturnTrueOnSignup = false
        
        super.init(delegate: nil)
    }
    
    override func doSignup(model: SignupModel) {
        if let expectation = self.expectation,
            let expectedUserName = self.expectedUserName,
            let expectedPassword = self.expectedPassword,
            let expectedEmailAddress = self.expectedEmailAddress{
            
            if ((model.userName.compare(expectedUserName) == .orderedSame) &&
                (model.password.compare(expectedPassword) == .orderedSame) &&
                (model.emailAddress.compare(expectedEmailAddress) == .orderedSame) ){
                
                expectation.fulfill()
            }
        }
        
        signupControllerDelegate?.signupResult(result: shouldReturnTrueOnSignup)
    }
    
}
