//
//  MainDataSource.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 23.06.21.
//

import CommonUI

class MainDataSource: CustomDataSource<DrinkViewModel> {
    
    weak var view: ViewControllerProtocol?
    
    var loader: CocktailsLoader
    
    init(loader: CocktailsLoader) {
        self.loader = loader
        super.init(sections: [], sectionStyle: .single)
        didLoad()
    }
    
    func didLoad() {
                
        loader.load(query: "m") { (result) in
            print(result)
            
            switch result {
            case let .success(drinksDTO):
                self.sections.append(CustomDataSource<DrinkViewModel>.Section(title: "New Drinks", items: drinksDTO.compactMap({ DrinkViewModel(name: $0.name, thumbnail: $0.strDrinkThumb, imageSource: $0.strImageSource) })))
                
                DispatchQueue.main.async {
                    self.view?.reload()
                }
            case let .failure(error):
                print(error)
                //TODO show error view
            }
        }
    }
}
