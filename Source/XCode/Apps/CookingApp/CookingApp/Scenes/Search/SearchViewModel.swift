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
    
    func search(_ textToSearch: String) {
        print(textToSearch)
        
        recipeLoader?.load(query: textToSearch, completion: { (result) in
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
