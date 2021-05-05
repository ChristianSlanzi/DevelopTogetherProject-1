//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 22.04.21.
//

import XCTest
import RecipeStore

extension FailableRetrieveRecipeStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
    }
}
