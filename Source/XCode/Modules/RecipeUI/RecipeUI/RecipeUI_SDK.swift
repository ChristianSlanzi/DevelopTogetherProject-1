//
//  RecipeUI.swift
//  RecipeUI
//
//  Created by Christian Slanzi on 13.05.21.
//

import UIKit

public class RecipeUI_SDK {
    
    public static func createRecipelistVC(router: RecipeRoute) -> CollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: RecipeUI_SDK.self))
        let recipeListVC = storyboard.instantiateViewController(identifier: "CollectionViewController") as! CollectionViewController
        let viewModel = CollectionViewModel(view: recipeListVC, router: router)
        recipeListVC.viewModel = viewModel
        return recipeListVC
    }
}
