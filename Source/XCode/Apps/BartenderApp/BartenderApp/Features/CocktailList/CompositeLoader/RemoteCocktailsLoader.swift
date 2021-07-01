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
    
    public func loadDrinks(withIds: [String], completion: @escaping CocktailsLoader.Result) {
        //TODO
        completion(.failure(CocktailsApiService.ServiceError.invalidData))
    }
    public func load(query: String, completion: @escaping CocktailsLoader.Result) {
        
        //        service.searchCocktailByName("margarita") { [weak self] result in
        //            guard let self = self else { return }
        //
        //            print(result)
        //        }
                
        //service.searchCocktailsByFirstLetter(" ") { [weak self] result in
        service.searchCocktailByName(query) { [weak self] result in
            guard let self = self else { return }
            self.mapResultToCompletion(result: result, completion: completion)
        }
    }
    
    public func loadDrinksByFirstLetter(_ letter: Character, completion: @escaping CocktailsLoader.Result) {
        service.searchCocktailsByFirstLetter(letter) { [weak self] result in
            guard let self = self else { return }
            self.mapResultToCompletion(result: result, completion: completion)
        }
    }
    
    private func mapResultToCompletion(result: CocktailsApiService.SearchResult, completion: @escaping CocktailsLoader.Result) {
        switch(result) {
        case let .success(data):
            completion(.success(data.drinks.map{ self.mapDtoToDrink($0) }))
        case let .failure(error):
            completion(.failure(error))
        }
    }
    
    private func mapDtoToDrink(_ dto: DrinkDTO) -> Drink {
        return Drink(idDrink: dto.idDrink,
                     strDrink: dto.strDrink,
                     strDrinkThumb: dto.strDrinkThumb,
                     strImageSource: dto.strImageSource,
                     strInstructions: dto.strInstructions,
                     ingredients: dto.ingredients.map{Drink.Ingredient(name: $0.0, measure: $0.1)},
                     strCategory: dto.strCategory,
                     strIBA: dto.strIBA,
                     strAlcoholic: dto.strAlcoholic,
                     strGlass: dto.strGlass)
    }
    
}
