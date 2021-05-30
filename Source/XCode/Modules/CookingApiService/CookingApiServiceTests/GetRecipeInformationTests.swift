//
//  GetRecipeInformationTests.swift
//  CookingApiServiceTests
//
//  Created by Christian Slanzi on 24.05.21.
//

import XCTest
import TestHelpers
@testable import CookingApiService

class GetRecipeInformationTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension GetRecipeInformationTests {
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: CookingApiRemote, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = CookingApiRemote(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
}

extension GetRecipeInformationTests {
    // MARK: - Tests
    
    func test_getRecipeInformation_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_searchRecipes_deliversSuccessWithItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()
        
        guard let filePath = Bundle(for: GetRecipeInformationTests.self).path(forResource: "RecipeInformationSample", ofType: "json") else {
          //fatalError("Couldn't find file 'Secrets.plist'.")
            print("Couldn't find file 'RecipeInformationSample.json'.")
            return
        }

        do {
            let recipeJson = try JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: filePath)), options: .allowFragments)
        let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
        
        let recipe1 = makeRecipe(id: 716429,
                                 calories: 584,
                                 carbs: "84g",
                                 fat: "20g",
                                 image: "https://spoonacular.com/recipeImages/716429-312x231.jpg",
                                 imageType: "jpg",
                                 protein: "19g",
                                 title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs")


        expect(sut, toCompleteWith: .success(recipe1.model), when: {
            client.complete(withStatusCode: 200, data: data)
        })
            
        } catch {
            return
        }
    }
}

extension GetRecipeInformationTests {
    
    private func makeRecipe(id: Int,
                            calories: Int,
                            carbs: String,
                            fat: String,
                            image: String,
                            imageType: String,
                            protein: String,
                            title: String) -> (model: RecipeInformationResultDTO, json: [String: Any]) {
        
        let item = RecipeInformationResultDTO(id: 716429, title: "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs", image: "https://spoonacular.com/recipeImages/716429-556x370.jpg", imageType: "jpg", servings: 2, readyInMinutes: 45, license: "CC BY-SA 3.0", sourceName: "Full Belly Sisters", sourceUrl: "http://fullbellysisters.blogspot.com/2012/06/pasta-with-garlic-scallions-cauliflower.html", spoonacularSourceUrl: "https://spoonacular.com/pasta-with-garlic-scallions-cauliflower-breadcrumbs-716429", aggregateLikes: 209, healthScore: 19.0, spoonacularScore: 83.0, pricePerServing: 163.15, analyzedInstructions: [], cheap: false, creditsText: "Full Belly Sisters", cuisines: [], dairyFree: false, diets: [], gaps: "no", glutenFree: false, instructions: "", ketogenic: false, lowFodmap: false, occasions: [], sustainable: false, vegan: false, vegetarian: false, veryHealthy: false, veryPopular: false, whole30: false, weightWatcherSmartPoints: 17, dishTypes: [
            "lunch",
            "main course",
            "main dish",
            "dinner"
        ], extendedIngredients: [], summary: "", winePairing: WinePairing(pairedWines: [
            "chardonnay",
            "gruener veltliner",
            "sauvignon blanc"
        ], pairingText: "Chardonnay, Gruener Veltliner, and Sauvignon Blanc are great choices for Pasta. Sauvignon Blanc and Gruner Veltliner both have herby notes that complement salads with enough acid to match tart vinaigrettes, while a Chardonnay can be a good pick for creamy salad dressings. The Buddha Kat Winery Chardonnay with a 4 out of 5 star rating seems like a good match. It costs about 25 dollars per bottle.", productMatches: []))
        
        let json = makeRecipeInformationJSON(recipe: item)
        
        return (item, json)
    }
    
    private func makeRecipeInformationJSON(recipe: RecipeInformationResultDTO) -> [String: Any] {
        
        let json = [
            "id": recipe.id,
            "title": recipe.title as Any,
            "image": recipe.image as Any,
            "imageType": recipe.imageType as Any,
            "servings": recipe.servings as Any,
            "readyInMinutes": recipe.readyInMinutes as Any
        ].compactMapValues { $0 }
        
        return json
    }
}
