//
//  SearchViewModel.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 15.07.21.
//

import Foundation

class SearchViewModel {
    
    typealias Routes = SearchRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    public var cocktailsLoader: CocktailsLoader?
    var lastTextSearched: String = ""
    
    func viewDidLoad() {
        lastTextSearched = ""
    }
    
    func search(_ textToSearch: String) {
        print(textToSearch)
        
        
        cocktailsLoader?.loadDrinksByIngredients([textToSearch], completion: { result in
        //cocktailsLoader?.load(query: textToSearch, completion: { result in
            switch result {
            case let .success(cocktails):
                guard !cocktails.isEmpty else {
                    
                    return
                }
                print(cocktails)
                
                DispatchQueue.main.async {
                    //self.router.openRecipeList(recipes)
                }
                
            case let .failure(error):
                
                print(error)
            }
        })
    }
}
