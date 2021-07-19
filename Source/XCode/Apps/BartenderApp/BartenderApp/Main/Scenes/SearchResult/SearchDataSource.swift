//
//  SearchDataSource.swift
//  BartenderApp
//
//  Created by Christian Slanzi on 18.07.21.
//

import CommonUI

class SearchDataSource: CustomDataSource<Drink>, ViewModelProtocol {
    
    weak var view: ViewControllerProtocol?
    
    init(drinks: [Drink]) {
        let section = CustomDataSource<Drink>.Section(title: "New Drinks", items: drinks)
        super.init(sections: [section], sectionStyle: .single)
    }
    
}
