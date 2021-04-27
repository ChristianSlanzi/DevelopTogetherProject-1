//
//  CookingApiServiceTests.swift
//  CookingApiServiceTests
//
//  Created by Christian Slanzi on 26.04.21.
//

import XCTest
import TestHelpers
@testable import CookingApiService

class CookingApiServiceTests: XCTestCase {

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

extension CookingApiServiceTests {
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: CookingApiRemote, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = CookingApiRemote(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
}

extension CookingApiServiceTests {
    // MARK: - Tests
    
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_searchRecipesTwice_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.searchRecipes { _ in }
        sut.searchRecipes { _ in }

        XCTAssertEqual(client.requestedURLs, [url.appendingPathComponent("recipes/complexSearch"), url.appendingPathComponent("recipes/complexSearch")])
    }
    
    func test_searchRecipes_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_searchRecipes_deliversInvalidDataErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]

        samples.enumerated().forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData), when: {
                let json = makeRecipesJSON([])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }
    
    func test_searchRecipes_deliversInvalidDataErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_searchRecipes_deliversSuccessWithNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let emptyListJSON = makeRecipesJSON([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        })
    }
    
    func test_searchRecipes_deliversSuccessWithItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        
        let recipe1 = makeRecipe(id: 716429,
                                 calories: 584,
                                 carbs: "84g",
                                 fat: "20g",
                                 image: "https://spoonacular.com/recipeImages/716429-312x231.jpg",
                                 imageType: "jpg",
                                 protein: "19g",
                                 title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs")
        
        let recipe2 = makeRecipe(id: 715538,
                                 calories: 521,
                                 carbs: "69g",
                                 fat: "10g",
                                 image: "https://spoonacular.com/recipeImages/715538-312x231.jpg",
                                 imageType: "jpg",
                                 protein: "35g",
                                 title: "What to make for dinner tonight?? Bruschetta Style Pork & Pasta")

        let user1 = makeRecipeSearchResult(offset: 0,
                                           number: 2,
                                           recipes: [recipe1.model, recipe2.model],
                                           totalResults: 86)

        expect(sut, toCompleteWith: .success(user1.model), when: {
            client.complete(withStatusCode: 200, data: makeRecipeSearchResultData(user: user1.json))
        })
    }
    
    func test_searchRecipes_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let url = URL(string: "http://any-url.com")!
        let client = HTTPClientSpy()
        var sut: CookingApiRemote? = CookingApiRemote(url: url, client: client)

        var capturedResults = [CookingApiRemote.RecipesSearchResult]()
        sut?.searchRecipes { capturedResults.append($0) }

        sut = nil
        client.complete(withStatusCode: 200, data: makeRecipesJSON([]))

        XCTAssertTrue(capturedResults.isEmpty)
    }
}

extension CookingApiServiceTests {
    
    private func makeRecipe(id: Int,
                            calories: Int,
                            carbs: String,
                            fat: String,
                            image: String,
                            imageType: String,
                            protein: String,
                            title: String) -> (model: RecipeDTO, json: [String: Any]) {
        
        let item = RecipeDTO(id: id,
                             calories: calories,
                             carbs: carbs,
                             fat: fat,
                             image: image,
                             imageType: imageType,
                             protein: protein,
                             title: title)
        
        let json = makeRecipeJSON(recipe: item)
        
        return (item, json)
    }
    
    private func makeRecipeJSON(recipe: RecipeDTO) -> [String: Any] {
        
        let json = [
            "id": recipe.id,
            "calories": recipe.calories as Any,
            "carbs": recipe.carbs as Any,
            "fat": recipe.fat as Any,
            "image": recipe.image as Any,
            "imageType": recipe.imageType as Any,
            "protein": recipe.protein as Any,
            "title": recipe.title as Any
        ].compactMapValues { $0 }
        
        return json
    }
    
    private func makeRecipesJSON(_ items: [[String: Any]]) -> Data {
        let json = ["results": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    private func makeRecipeSearchResult(offset: Int,
                                        number: Int,
                                        recipes: [RecipeDTO],
                                        totalResults: Int) -> (model: RecipesSearchResultDTO, json: [String: Any]) {
        
        let searchResult = RecipesSearchResultDTO(offset: offset,
                                                  number: number,
                                                  results: recipes,
                                                  totalResults: totalResults)
        let recipesJson: [[String: Any]] = recipes.map { makeRecipeJSON(recipe: $0) }
        
        let json = [
            "offset": offset as Any,
            "number": number as Any,
            "results": recipesJson as Any,
            "totalResults": totalResults as Any
        ].compactMapValues { $0 }
        
        return (searchResult, json)
    }
    
    private func makeRecipeSearchResultData(user: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: user)
    }
}
