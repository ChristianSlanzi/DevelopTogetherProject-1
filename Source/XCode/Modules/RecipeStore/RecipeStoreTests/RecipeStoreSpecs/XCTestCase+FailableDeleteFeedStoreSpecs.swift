//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 26.04.21.
//

import XCTest
import RecipeStore

extension FailableDeleteRecipeStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionError(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)

        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }
    
//    func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #filePath, line: UInt = #line) {
//        deleteCache(from: sut)
//
//        expect(sut, toRetrieve: .empty, file: file, line: line)
//    }
}
