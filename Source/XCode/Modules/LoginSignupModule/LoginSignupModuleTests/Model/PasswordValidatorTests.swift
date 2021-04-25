//
//  PasswordValidatorTests.swift
//  LoginSignupModuleTests
//
//  Created by Christian Slanzi on 25.04.21.
//

import XCTest
@testable import LoginSignupModule

class PasswordValidatorTests: XCTestCase {

    fileprivate let emptyString = ""
    
    fileprivate let validPassword1 = "aou4%F"
    fileprivate let validPassword2 = "aou4AF%"
    fileprivate let validPassword3 = "aou4AF%0"
    fileprivate let validPassword4 = "aou4AF%0#"
    fileprivate let validPassword5 = "D%io7AFn9Y"
    
    fileprivate let invalidPassword1 = "a3$Am"
    fileprivate let invalidPassword2 = "abdtmg"
    fileprivate let invalidPassword3 = "ABCDEF"
    fileprivate let invalidPassword4 = "Abdtmg"
    fileprivate let invalidPassword5 = "4bdtmg"
    fileprivate let invalidPassword6 = "4*(A£$9"
    fileprivate let invalidPassword7 = "4bdtmgTYS0A"
    
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

}

// MARK: Empty string validation
extension PasswordValidatorTests {
    
    func testValidate_EmptyString_ReturnsFalse() {
        let validator = PasswordValidator()
        XCTAssertFalse(validator.validate(emptyString), "string can not be empty.")
    }
    
}
