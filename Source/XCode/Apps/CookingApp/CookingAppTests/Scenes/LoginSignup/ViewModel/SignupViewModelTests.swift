//
//  SignupViewModelTests.swift
//  CookingAppTests
//
//  Created by Christian Slanzi on 27.04.21.
//

import XCTest

class SignupViewModelTests: XCTestCase {
    
    fileprivate var mockSignupViewController: MockSignupViewController?
    
    fileprivate var validUserName = "abcdefghij"
    fileprivate var invalidUserName = "a"
    
    fileprivate let validPassword = "D%io7AFn9Y"
    fileprivate let validPassword2 = "B%un9AG91A"
    fileprivate let invalidPassword = "a3$Am"
    
    fileprivate let validEmailAddress = "a@b.com"

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
