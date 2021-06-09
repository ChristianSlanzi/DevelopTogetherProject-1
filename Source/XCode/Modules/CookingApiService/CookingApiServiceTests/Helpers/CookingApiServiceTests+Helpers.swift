//
//  CookingApiServiceTests+Helpers.swift
//  CookingApiServiceTests
//
//  Created by Christian Slanzi on 26.04.21.
//

import XCTest
import CookingApiService

extension CookingApiServiceTests {
    func expect(_ sut: CookingApiProtocol, toCompleteWith expectedResult: Result<RecipesSearchResultDTO, CookingApiServiceError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for call completion")
        
        sut.searchRecipes { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedUserData), .success(expectedUserData)):
                XCTAssertEqual(receivedUserData, expectedUserData, file: file, line: line)
                
            case let (.failure(receivedError), .failure(expectedError)):
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
