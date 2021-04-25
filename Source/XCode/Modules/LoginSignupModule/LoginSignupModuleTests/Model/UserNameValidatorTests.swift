//
//  UserNameValidatorTests.swift
//  LoginSignupModuleTests
//
//  Created by Christian Slanzi on 25.04.21.
//

import XCTest
@testable import LoginSignupModule

class UserNameValidatorTests: XCTestCase {
    
    fileprivate let emptyString = ""
        
    fileprivate let singleCharacterName = "a"
    fileprivate let twoCharacterName = "ab"
    fileprivate let tenCharacterName = "abcdefghij"
    fileprivate let elevenCharacterName = "abcdefghijk"

    fileprivate let nameWithWhitespace = "abc def"
    fileprivate let nameWithUnderscore = "abc_def"

    fileprivate let nameWithDigit0 = "abc00"
    fileprivate let nameWithDigit1 = "abc11"
    fileprivate let nameWithDigit2 = "abc22"
    fileprivate let nameWithDigit3 = "abc33"
    fileprivate let nameWithDigit4 = "abc44"
    fileprivate let nameWithDigit5 = "abc55"
    fileprivate let nameWithDigit6 = "abc66"
    fileprivate let nameWithDigit7 = "abc77"
    fileprivate let nameWithDigit8 = "abc88"
    fileprivate let nameWithDigit9 = "abc99"

    fileprivate let nameWithUnsupportedSpecialCharacters1 = "+-.,!@#$%"
    fileprivate let nameWithUnsupportedSpecialCharacters2 = "^&*();\\/|"
    fileprivate let nameWithUnsupportedSpecialCharacters3 = "<>\""

    fileprivate let nameWithAlphabets1 = "ABCDEFGH"
    fileprivate let nameWithAlphabets2 = "IJKLMNOP"
    fileprivate let nameWithAlphabets3 = "QRSTUVWX"
    fileprivate let nameWithAlphabets4 = "YYYYZZZZ"
    fileprivate let nameWithAlphabets5 = "abcdefgh"
    fileprivate let nameWithAlphabets6 = "ijklmnop"
    fileprivate let nameWithAlphabets7 = "qrstuvwx"
    fileprivate let nameWithAlphabets8 = "yyyyzzzz"

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
extension UserNameValidatorTests {
  
 func testValidate_EmptyString_ReturnsFalse() {
  let validator = UserNameValidator()
  XCTAssertFalse(validator.validate(emptyString), "string can not be empty.")
 }
}

// MARK: whitespace validation
extension UserNameValidatorTests {
    
  func testValidate_StringWithWhitespace_ReturnsFalse() {
    let validator = UserNameValidator()
    XCTAssertFalse(validator.validate(nameWithWhitespace), "string can not be have whitespace.")
     }
}

// MARK: underscore validation
extension UserNameValidatorTests {
    
  func testValidate_StringWithUnderscore_ReturnsTrue() {
    let validator = UserNameValidator()
    XCTAssertTrue(validator.validate(nameWithUnderscore), "/(nameWithUnderscore) should have been valid.")
  }
}

// MARK: String length validation
extension UserNameValidatorTests {
    
    func testValidate_InputLessThanTwoCharachtersInLength_ReturnsFalse() {
        let validator = UserNameValidator()
        XCTAssertFalse(validator.validate(singleCharacterName), "/(twoCharacterName) should not have been valid.")
    }
    
    func testValidate_InputGreaterThanTenCharachtersInLength_ReturnsFalse() {
        let validator = UserNameValidator()
        XCTAssertFalse(validator.validate(elevenCharacterName), "/(elevenCharacterName) should not have been valid.")
    }
    
    func testValidate_InputTwoCharachtersInLength_ReturnsTrue() {
        let validator = UserNameValidator()
        XCTAssertTrue(validator.validate(twoCharacterName), "/(twoCharacterName) should have been valid.")
    }
    
    func testValidate_InputTenCharachtersInLength_ReturnsTrue() {
        let validator = UserNameValidator()
        XCTAssertTrue(validator.validate(tenCharacterName), "/(tenCharacterName) should have been valid.")
    }
}

// MARK: special character validation
extension UserNameValidatorTests {
    
 func testValidate_StringWithSpecialCharacters1_ReturnsFalse() {
  let validator = UserNameValidator()
   XCTAssertFalse(validator.validate(nameWithUnsupportedSpecialCharacters1), "/(nameWithUnsupportedSpecialCharacters1) should not have been valid.")
 }
 
 func testValidate_StringWithSpecialCharacters2_ReturnsFalse() {
  let validator = UserNameValidator()
  XCTAssertFalse(validator.validate(nameWithUnsupportedSpecialCharacters2), "/(nameWithUnsupportedSpecialCharacters2) should not have been valid.")
 }
    
 func testValidate_StringWithSpecialCharacters3_ReturnsFalse() {
  let validator = UserNameValidator()
  XCTAssertFalse(validator.validate(nameWithUnsupportedSpecialCharacters3), "/(nameWithUnsupportedSpecialCharacters3) should not have been valid.")
 }
}
