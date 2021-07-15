//
//  MainDataSource.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 23.06.21.
//

import CommonUI

class MainDataSource: CustomDataSource<Drink>, ViewModelProtocol {
    
    weak var view: ViewControllerProtocol?
    
    var loader: CocktailsLoader
    
    init(loader: CocktailsLoader) {
        self.loader = loader
        super.init(sections: [], sectionStyle: .single)
        reloadData()
    }
    
    override func reloadData() {
                
        loader.load(query: "m") { (result) in
            print(result)
            
            switch result {
            case let .success(drinksDTO):
                self.sections.removeAll()
                self.sections.append(CustomDataSource<Drink>.Section(title: "New Drinks", items: drinksDTO))
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
