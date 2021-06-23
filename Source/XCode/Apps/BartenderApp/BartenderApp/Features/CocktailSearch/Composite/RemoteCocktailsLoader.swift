//
//  RemoteCocktailsLoader.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//

import CocktailsApiService

public class RemoteCocktailsLoader: CocktailsLoader {
    
    var service: CocktailsApiService
    
    init(service: CocktailsApiService) {
        self.service = service
    }
    
    public func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
        
        //        service.searchCocktailByName("margarita") { [weak self] result in
        //            guard let self = self else { return }
        //
        //            print(result)
        //        }
                
        service.searchCocktailsByFirstLetter("m") { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case let .success(data):
                completion(.success(data.drinks.map({ (dto) in
                    Drink(idDrink: dto.idDrink, strDrink: dto.strDrink)
                })))

            case let .failure(error):
                completion(.failure(error))
            break
            }
        }
    }
    
}
