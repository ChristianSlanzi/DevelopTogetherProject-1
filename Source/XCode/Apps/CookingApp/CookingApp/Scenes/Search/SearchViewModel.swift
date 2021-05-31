//
//  SearchViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 31.05.21.
//

import Foundation
import RecipeFeature

class SearchViewModel {
    
    public var recipeLoader: RecipeLoader?
    var lastTextSearched: String = ""
    
    func viewDidLoad() {
        lastTextSearched = ""
    }
    
    func searchBarSearchButtonClicked(textToSearch: String) {
        print(textToSearch)
        
        recipeLoader?.load(query: textToSearch, completion: { (result) in
            switch result {
            case let .success(recipes):
                guard !recipes.isEmpty else {
                    
                    return
                }
                print(recipes)
            case let .failure(error):
                
                print(error)
            }

        })
    }
}
