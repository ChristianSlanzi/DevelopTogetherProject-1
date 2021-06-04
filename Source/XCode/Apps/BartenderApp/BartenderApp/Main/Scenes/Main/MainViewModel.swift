//
//  MainViewModel.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

final class MainViewModel {

    var loader: CocktailsLoader
    
    init(loader: CocktailsLoader) {
        self.loader = loader
    }
    
    func didLoad() {
        
        loader.load(query: "m") { (result) in
            print(result)
        }
    }
}
