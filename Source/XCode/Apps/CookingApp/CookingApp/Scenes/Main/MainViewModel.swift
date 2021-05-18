//
//  MainViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 30.04.21.
//

import Foundation
import CookingApiService
import RecipeStore
import RecipeFeature

final class MainViewModel {
    
    var cookingApiService: CookingApiService?
    var recipeStore: RecipeStore?
    
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
                //recipeStore?.create([searchResult.results], completion: { (error) in
                //    <#code#>
                //})
            }
        })
    }

    func recipeButtonTouchUpInside() {
        print("Recipe Button pressed")
        router.openRecipe(Recipe(id: 23, image: "cacciatora", imageType: "jpg", title: "Pollo alla cacciatora"))
    }
}
