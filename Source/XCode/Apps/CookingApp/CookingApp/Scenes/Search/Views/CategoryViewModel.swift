//
//  CategoryViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 02.06.21.
//

import Foundation

public enum Cuisine: String {
    case italian
    case French
    case American
    case Chinese
    case Japanese
    case Russian
}

public class CategoryViewModel {
    
    var categories = [Cuisine]()
    weak var view: CategoriesViewProtocol?
    
    init() {
        //add some categories
        categories.append(.italian)
        categories.append(.French)
        categories.append(.American)
        categories.append(.Chinese)
        categories.append(.Japanese)
        categories.append(.Russian)
    }
    
    func onCategorySelected(index: Int) {
        if index < categories.count {
            view?.searchRecipesForCategory(categories[index])
        }
    }
}
