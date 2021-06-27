//
//  FavoriteDataSource.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 26.06.21.
//

import CommonUI

class FavoriteDataSource: CustomDataSource<Drink>, ViewModelProtocol {
    
    weak var view: ViewControllerProtocol?
    
    var loader: CocktailsManaging
    
    init(loader: CocktailsManaging) {
        self.loader = loader
        super.init(sections: [], sectionStyle: .single)
        reloadData()
    }
    
    override func reloadData() {
            
        loader.getFavorites { drinks in
            self.sections = []
            self.sections.append(CustomDataSource<Drink>.Section(title: "Favorites", items: drinks))
            DispatchQueue.main.async {
                self.view?.reload()
            }
        }
    }
}
