//
//  SearchViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 31.05.21.
//

import Foundation
import RecipeFeature

class SearchViewModel {
    
    typealias Routes = SearchRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
        
        
    }
    
    public var recipeLoader: RecipeLoader?
    var lastTextSearched: String = ""
    
    func viewDidLoad() {
        lastTextSearched = ""
    }
    
    
    func searchForIngredients(_ textToSearch: String) {
        print(textToSearch)
        
        recipeLoader?.load(predicate: NSPredicate(format:"ingredients CONTAINS '\(textToSearch)'"), completion: { (result) in
            switch result {
            case let .success(recipes):
                guard !recipes.isEmpty else {
                    
                    return
                }
                print(recipes)
                
                DispatchQueue.main.async {
                    self.router.openRecipeList(recipes)
                }
                
            case let .failure(error):
                
                print(error)
            }

        })
    }
    
    func search(_ textToSearch: String) {
        print(textToSearch)
        
        recipeLoader?.load(predicate: NSPredicate(format:"title CONTAINS '\(textToSearch)'"), completion: { (result) in
            switch result {
            case let .success(recipes):
                guard !recipes.isEmpty else {
                    
                    return
                }
                print(recipes)
                
                DispatchQueue.main.async {
                    self.router.openRecipeList(recipes)
                }
                
            case let .failure(error):
                
                print(error)
            }

        })
    }
    
    func searchRecipesForNutrients(_ nutrients: [String: Int]) {
        // convert the dictionary in the loader's NutrientParameters type
        var numbers = [NutrientParameters.NumberParameters : Int]()
        for nutrient in nutrients {
            if let key = NutrientParameters.NumberParameters(rawValue: nutrient.key) {
                numbers[key] = nutrient.value
            }
        }
        
        let parameters: NutrientParameters = NutrientParameters(numbers: numbers, booleans: [:] /*[.random : true]*/)
        recipeLoader?.loadRecipesByNutrients(parameters, completion: { (result) in
            switch result {
            case let .success(recipes):
                guard !recipes.isEmpty else {
                    
                    return
                }
                print(recipes)
                
                DispatchQueue.main.async {
                    self.router.openRecipeList(recipes)
                }
                
            case let .failure(error):
                
                print(error)
            }

        })
    }
}
