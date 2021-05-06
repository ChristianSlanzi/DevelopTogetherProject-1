//
//  RecipeStoreTests.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 05.05.21.
//

import XCTest
import CoreData
import TestHelpers
@testable import RecipeStore

class RecipeStoreTests: XCTestCase {

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

extension RecipeStoreTests: FailableRecipeStoreSpecs {
    
    func test_retrieve_deliversEmptyOnEmptyCache() throws {
        let sut = try makeSUT()

        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() throws {
        let sut = try makeSUT()

        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() throws {
        let sut = try makeSUT()

        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() throws {
        let sut = try makeSUT()

        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }

    func test_retrieve_deliversFailureOnRetrievalError() throws {
        let stub = NSManagedObjectContext.alwaysFailingFetchStub()
        stub.startIntercepting()

        let sut = try makeSUT()

        assertThatRetrieveDeliversFailureOnRetrievalError(on: sut)
    }

    func test_retrieve_hasNoSideEffectsOnFailure() throws {
        let stub = NSManagedObjectContext.alwaysFailingFetchStub()
        stub.startIntercepting()

        let sut = try makeSUT()

        assertThatRetrieveHasNoSideEffectsOnFailure(on: sut)
    }

    func test_insert_deliversNoErrorOnEmptyCache() throws {
        let sut = try makeSUT()

        assertThatInsertDeliversNoErrorOnEmptyCache(on: sut)
    }

    func test_insert_deliversNoErrorOnNonEmptyCache() throws {
        let sut = try makeSUT()

        assertThatInsertDeliversNoErrorOnNonEmptyCache(on: sut)
    }

    func test_insert_overridesPreviouslyInsertedCacheValues() throws {
        let sut = try makeSUT()

        assertThatInsertOverridesPreviouslyInsertedCacheValues(on: sut)
    }

    func test_insert_deliversErrorOnInsertionError() throws {
        let stub = NSManagedObjectContext.alwaysFailingSaveStub()
        stub.startIntercepting()

        let sut = try makeSUT()

        assertThatInsertDeliversErrorOnInsertionError(on: sut)
    }

    func test_insert_hasNoSideEffectsOnInsertionError() throws {
        let stub = NSManagedObjectContext.alwaysFailingSaveStub()
        stub.startIntercepting()

        let sut = try makeSUT()

        assertThatInsertHasNoSideEffectsOnInsertionError(on: sut)
    }

    func test_delete_deliversNoErrorOnEmptyCache() throws {

    }

    func test_delete_hasNoSideEffectsOnEmptyCache() throws {

    }

    func test_delete_deliversNoErrorOnNonEmptyCache() throws {

    }

    func test_delete_emptiesPreviouslyInsertedCache() throws {

    }

    func test_delete_deliversErrorOnDeletionError() throws {

    }

    func test_delete_hasNoSideEffectsOnDeletionError() throws {

    }

    func test_storeSideEffects_runSerially() throws {

    }
    
}

extension RecipeStoreTests {
    
    // - MARK: Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) throws -> RecipeStore {
        let inMemoryStoreURL = URL(fileURLWithPath: "/dev/null")
        let sut = try CoreDataRecipeStore(storeURL: inMemoryStoreURL)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
