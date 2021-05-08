//
//  XCTestCase+RecipeStoreHelpers.swift
//  RecipeStoreTests
//
//  Created by Christian Slanzi on 21.04.21.
//

import XCTest
import RecipeStore

func uniqueRecipeFeed() -> [LocalRecipe] {
    [uniqueRecipe(), uniqueRecipe2()]
}

func uniqueRecipe() -> LocalRecipe {
    LocalRecipe(id: 22, calories: 350, carbs: "20g", fat: "15g", image: "rec-image", imageType: ".jpg", protein: "20g", title: "a test recipe")
}
func uniqueRecipe2() -> LocalRecipe {
    LocalRecipe(id: 23, calories: 450, carbs: "25g", fat: "25g", image: "rec-image", imageType: ".jpg", protein: "20g", title: "another test recipe")
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

extension XCTestCase {
    
    @discardableResult
    func insert(_ cache: (feed: [LocalRecipe], timestamp: Date), to sut: RecipeStore) -> Error? {
        let exp = expectation(description: "Wait for cache insertion")
        var insertionError: Error?
        sut.create(cache.feed) { receivedInsertionError in
            insertionError = receivedInsertionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return insertionError
    }
    
    @discardableResult
    func deleteCache(from sut: RecipeStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?
        sut.deleteAll(entity: LocalRecipe.self) { receivedDeletionError in
            deletionError = receivedDeletionError
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
    func expect(_ sut: RecipeStore, toRetrieveTwice expectedResult: RetrieveCachedRecipesResult, file: StaticString = #filePath, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: RecipeStore, toRetrieve expectedResult: RetrieveCachedRecipesResult, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        let recipeSortDescriptor: NSSortDescriptor = NSSortDescriptor(
            key: #keyPath(CoreDataRecipe.calories),
            ascending: true)
        
        sut.retrieve(sortDescriptors: [recipeSortDescriptor]) { (retrievedResult: RetrieveDataResult<LocalRecipe>) in
            switch (expectedResult, retrievedResult) {
            case (.empty, .empty),
                 (.failure, .failure):
                break
                
            case let (.found(expectedRecipe), .found(retrievedRecipe)):
                XCTAssertEqual(retrievedRecipe, expectedRecipe, file: file, line: line)
                //XCTAssertEqual(retrievedTimestamp, expectedTimestamp, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}
