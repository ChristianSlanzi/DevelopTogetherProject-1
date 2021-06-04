//
//  MainViewModel.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import CocktailsApiService

final class MainViewModel {

    var service: CocktailsApiService
    
    init(service: CocktailsApiService) {
        self.service = service
    }
    
    func didLoad() {
        
        //        service.searchCocktailByName("margarita") { [weak self] result in
        //            guard let self = self else { return }
        //
        //            print(result)
        //        }
                
        service.searchCocktailsByFirstLetter("m") { [weak self] result in
            guard let self = self else { return }
            
            print(result)
        }
    }
}
