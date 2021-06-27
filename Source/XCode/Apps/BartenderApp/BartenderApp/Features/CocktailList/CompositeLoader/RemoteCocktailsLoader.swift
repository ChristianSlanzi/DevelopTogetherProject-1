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
    
    public func loadDrinks(withIds: [String], completion: @escaping (Result<[Drink], Error>) -> Void) {
        //TODO
        completion(.failure(CocktailsApiService.ServiceError.invalidData))
    }
    public func load(query: String, completion: @escaping (CocktailsLoader.Result) -> Void) {
        
        //        service.searchCocktailByName("margarita") { [weak self] result in
        //            guard let self = self else { return }
        //
        //            print(result)
        //        }
                
        //service.searchCocktailsByFirstLetter(" ") { [weak self] result in
        service.searchCocktailByName(query) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case let .success(data):
                completion(.success(data.drinks.map({ (dto) in
                    
                    return Drink(idDrink: dto.idDrink, strDrink: dto.strDrink, strDrinkThumb: dto.strDrinkThumb, strImageSource: dto.strImageSource, strInstructions: dto.strInstructions, ingredients: dto.ingredients)
                })))

            case let .failure(error):
                completion(.failure(error))
            break
            }
        }
    }
    
    public func loadDrinksByFirstLetter(_ letter: Character, completion: @escaping (Result<[Drink], Error>) -> Void) {
        service.searchCocktailsByFirstLetter(letter) { [weak self] result in
            guard let self = self else { return }
            
            switch(result) {
            case let .success(data):
                completion(.success(data.drinks.map({ (dto) in
                    
                    return Drink(idDrink: dto.idDrink, strDrink: dto.strDrink, strDrinkThumb: dto.strDrinkThumb, strImageSource: dto.strImageSource, strInstructions: dto.strInstructions, ingredients: dto.ingredients)
                })))

            case let .failure(error):
                completion(.failure(error))
            break
            }
        }
    }
    
}
