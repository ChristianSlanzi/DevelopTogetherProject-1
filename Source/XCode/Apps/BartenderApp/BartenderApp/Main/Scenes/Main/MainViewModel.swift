//
//  MainViewModel.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 04.06.21.
//
    
struct DrinkViewModel {
    var name: String
    var thumbnail: String
    var imageSource: String?
}

protocol ViewModelProtocol {
    var view: ViewControllerProtocol? { get set }
}
    
final class MainViewModel: ViewModelProtocol {
    
    weak var view: ViewControllerProtocol?

    var drinks: [DrinkViewModel]
    var loader: CocktailsLoader
    
    init(loader: CocktailsLoader) {
        self.loader = loader
        self.drinks = [DrinkViewModel]()
    }
    
    func didLoad() {
                
        loader.load(query: " ") { (result) in
            print(result)
            
            switch result {
            case let .success(drinksDTO):
                self.drinks = drinksDTO.compactMap({ DrinkViewModel(name: $0.name, thumbnail: $0.strDrinkThumb, imageSource: $0.strImageSource) })
                self.view?.reload()
                break
            case let .failure(error):
                print(error)
                //TODO show error view
                break
            }
            
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int { drinks.count }
    
    func cellViewModel(row: Int, section: Int) -> DrinkViewModel? {
        if ((row < 0) || (row >= drinks.count)) {
            return nil
        }
        
        return DrinkViewModel(name: drinks[row].name, thumbnail: drinks[row].thumbnail, imageSource: drinks[row].imageSource)
    }
}
