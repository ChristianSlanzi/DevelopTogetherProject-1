//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 26.04.21.
//

import XCTest
import RecipeStore

extension FailableInsertRecipeStoreSpecs where Self: XCTestCase {
    func assertThatInsertDeliversErrorOnInsertionError(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueRecipeFeed(), Date()), to: sut)
        
        XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
    }
    
    func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueRecipeFeed(), Date()), to: sut)
        
        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
}
