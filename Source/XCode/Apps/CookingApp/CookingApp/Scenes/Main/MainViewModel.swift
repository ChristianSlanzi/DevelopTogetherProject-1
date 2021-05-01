//
//  MainViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import Foundation
import CookingApiService

final class MainViewModel {
    
    var cookingApiService: CookingApiService?
    
    typealias Routes = RecipeRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func didLoad() {
        cookingApiService?.searchRecipes(completion: { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let searchResult):
                print(searchResult.results)
            }
        })
    }

    func recipeButtonTouchUpInside() {
        print("Recipe Button pressed")
        router.openRecipe()
    }
}
