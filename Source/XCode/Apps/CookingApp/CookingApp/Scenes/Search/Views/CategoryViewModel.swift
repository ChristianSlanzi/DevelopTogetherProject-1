//
//  CategoryViewModel.swift
//  CookingApp
//
//  Created by Christian Slanzi on 02.06.21.
//

import Foundation

public enum Cuisine: String {
    case italian
    case french
    case american
    case chinese
    case japanese
    case russian
}

public class CategoryViewModel {
    
    var categories = [Cuisine]()
    weak var view: CategoriesViewProtocol?
    
    init() {
        //add some categories
        categories.append(.italian)
        categories.append(.french)
        categories.append(.american)
        categories.append(.chinese)
        categories.append(.japanese)
        categories.append(.russian)
    }
    
    func onCategorySelected(index: Int) {
        if index < categories.count {
            view?.searchRecipesForCategory(categories[index])
        }
    }
}
