//
//  GetRecipeInformationTests+Helpers.swift
//  CookingApiServiceTests
//
//  Created by Christian Slanzi on 24.05.21.
//

import XCTest
import CookingApiService

extension GetRecipeInformationTests {
    func expect(_ sut: CookingApiService, toCompleteWith expectedResult: Result<RecipeInformationResultDTO, CookingApiServiceError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for call completion")
        
        sut.getRecipeInformation(recipeId: 20) { receivedResult in
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
