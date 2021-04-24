//
//  UserApiServiceTests+Helpers.swift
//  UserApiServiceTests
//
//  Created by Christian Slanzi on 23.04.21.
//

import XCTest
import UserApiService

extension UserApiServiceTests {
    
    func expect(_ sut: UserApiService, toCompleteWith expectedResult: Result<UserData, UserApiServiceError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for call completion")
        
        sut.getUsersList { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedUserData), .success(expectedUserData)):
                XCTAssertEqual(receivedUserData, expectedUserData, file: file, line: line)
                
            case let (.failure(receivedError as UserApiServiceError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        waitForExpectations(timeout: 0.1)
    }
    
    func expect(_ sut: UserApiService, toCompleteCreateUserWith expectedResult: Result<JobUser, UserApiServiceError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for call completion")
        
        sut.createUser { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedUserData), .success(expectedUserData)):
                XCTAssertEqual(receivedUserData, expectedUserData, file: file, line: line)
                
            case let (.failure(receivedError as UserApiServiceError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        waitForExpectations(timeout: 0.1)
    }
}
