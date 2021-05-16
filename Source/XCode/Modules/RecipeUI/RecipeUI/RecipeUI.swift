//
//  RecipeUI.swift
//  RecipeUI
//
//  Created by Christian Slanzi on 13.05.21.
//

import UIKit

public class RecipeUI {
    
    public static func createRecipelistVC() -> CollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: RecipeUI.self))
        let recipeListVC = storyboard.instantiateViewController(identifier: "CollectionViewController") as! CollectionViewController
        let viewModel = CollectionViewModel(view: recipeListVC)
        recipeListVC.viewModel = viewModel
        return recipeListVC
    }
}
