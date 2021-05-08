//
//  XCTestCase+RecipeStoreSpecs.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 21.04.21.
//

import XCTest
import RecipeStore

extension RecipeStoreSpecs where Self: XCTestCase {
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: .empty, file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .empty, file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let feed = uniqueRecipeFeed()
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        expect(sut, toRetrieve: .found(feed: feed), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let feed = uniqueRecipeFeed()
        let timestamp = Date()
        
        insert((feed, timestamp), to: sut)
        
        expect(sut, toRetrieveTwice: .found(feed: feed), file: file, line: line)
    }
    
    func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let insertionError = insert((uniqueRecipeFeed(), Date()), to: sut)

        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }

    func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueRecipeFeed(), Date()), to: sut)

        let insertionError = insert((uniqueRecipeFeed(), Date()), to: sut)

        XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
    }

    func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueRecipeFeed(), Date()), to: sut)

        let latestFeed = uniqueRecipeFeed()
        let latestTimestamp = Date()
        insert((latestFeed, latestTimestamp), to: sut)

        expect(sut, toRetrieve: .found(feed: latestFeed), file: file, line: line)
    }

    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)

        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }

    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        deleteCache(from: sut)

        expect(sut, toRetrieve: .empty, file: file, line: line)
    }

    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueRecipeFeed(), Date()), to: sut)

        let deletionError = deleteCache(from: sut)

        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }

    func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        insert((uniqueRecipeFeed(), Date()), to: sut)

        deleteCache(from: sut)

        expect(sut, toRetrieve: .empty, file: file, line: line)
    }

    func assertThatSideEffectsRunSerially(on sut: RecipeStore, file: StaticString = #filePath, line: UInt = #line) {
        let op1 = expectation(description: "Operation 1")
        sut.create(uniqueRecipeFeed()) { _ in
            op1.fulfill()
        }

        let op2 = expectation(description: "Operation 2")
        sut.deleteAll(entity: LocalRecipe.self) { _ in
            op2.fulfill()
        }

        let op3 = expectation(description: "Operation 3")
        sut.create(uniqueRecipeFeed()) { _ in
            op3.fulfill()
        }
        
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataRecipe.idCode),
            ascending: true)

        let op4 = expectation(description: "Operation 4")
        sut.retrieve(sortDescriptors: [recipeSortDescriptor]) { (_: RetrieveDataResult<LocalRecipe>) in
            op4.fulfill()
        }

        wait(for: [op1, op2, op3, op4], timeout: 5.0, enforceOrder: true)
    }
}
